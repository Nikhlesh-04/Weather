//
//  DetailViewController.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    var weatherViewModel:WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setup()
        self.tableView.reloadData()
    }
    
    func setup() {
        if let model = weatherViewModel?.currentWeather {
            self.name.text = model.name
            self.lat.text = "\(model.coord?.lat ??  0.0)"
            self.long.text = "\(model.coord?.lon ??  0.0)"
            self.descriptions.text = "\(model.weather.first?.description ?? "")"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
