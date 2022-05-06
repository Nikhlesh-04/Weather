//
//  ViewController.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager = CLLocationManager()
    var annatation = MKPointAnnotation()
    var location:CLLocation?
    
    var tapGesture:UITapGestureRecognizer?
    
    var weatherViewModel:WeatherViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupLocation()
    }
    
    func setupLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
                
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()
        
        if let coordinate = self.mapView.userLocation.location?.coordinate {
            self.mapView.setCenter(coordinate, animated: true)
        }
        
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnMap(gestureRecognizer:)))
        self.tapGesture = tapGestures
        self.mapView.addGestureRecognizer(tapGestures)
        
    }
    
    @objc func didTapOnMap(gestureRecognizer:UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: self.mapView)
        let locationCoord:CLLocationCoordinate2D = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        print(locationCoord.latitude)
        print(locationCoord.longitude)
        self.updateMap(location: locationCoord)
        
        self.fetchOldDataAndMove(locationCoord: locationCoord)
    }
    
    func fetchOldDataAndMove(locationCoord:CLLocationCoordinate2D) {
        self.weatherViewModel = WeatherViewModel()
        self.weatherViewModel?.fetch()
        self.weatherViewModel?.fetchTapData(lat: locationCoord.latitude, long: locationCoord.longitude, complition: { (status, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
            } else {
                // Delay for user can see where he tap
                DispatchQueue.main.async {
                    self.moveToDetail()
                }
            }
        })
    }
    
    func moveToDetail() {
        if let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detail.weatherViewModel = self.weatherViewModel
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }


}

extension ViewController:CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location: CLLocationCoordinate2D = manager.location?.coordinate {
            self.updateMap(location: location)
        }
    }
    
    func updateMap(location:CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        annatation.coordinate = location
        annatation.title = "My Location"
        self.mapView.addAnnotation(annatation)
    }
}

