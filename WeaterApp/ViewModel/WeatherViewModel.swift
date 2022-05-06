//
//  WeatherViewModel.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit
import CoreData

class WeatherViewModel {

    var hudVisible:Bool = true
    private(set) var currentWeather:WeatherModel?
    private(set) var weathers:[WeatherCoreData] = []
    
    init() {}
    
    func fetch() {
        // Retrive Data from DB ans assigne to weathers
        let sort = NSSortDescriptor(key: "insertTime", ascending: false)
        
        guard let fetch = CoreDataStack.shared.fetchEntities(entity: WeatherCoreData.self, storeDescriptors:[sort]) else {
            return
        }
        self.weathers = fetch
    }
    
    func fetchTapData(lat: Double, long: Double, complition:((_ status:Bool, _ error:Error?) -> Void)?) {
        APIService().getWeather(lat: lat, long: long) { (model, error) in
            if let data = model {
                self.currentWeather = data
                complition?(true,nil)
                //SAVE currentWeather TO CORE DATA HERE
                self.saveDataToDB(model: data)
            } else if let error = error {
                print(error.localizedDescription)
                complition?(false,error)
            }
        }
    }
    
    private func saveDataToDB(model:WeatherModel) {
        let object = WeatherCoreData(context: CoreDataStack.shared.managedContext)
        object.name = model.name
        object.id = Int64(model.id)
        object.lat = Double(model.coord?.lat ??  0.0)
        object.lon = Double(model.coord?.lon ??  0.0)
        object.temp = Double(model.main?.temp ??  0.0)
        object.temp_max = Double(model.main?.temp_max ??  0.0)
        object.temp_min = Double(model.main?.temp_min ??  0.0)
        object.id = Int64(model.weather.first?.id ?? 0)
        object.descriptions = model.weather.first?.description ?? ""
        object.insertTime = Date()
        
        let result = CoreDataStack.shared.saveContext()
        if result == .success {
            print("Saved In DB")
        } else {
            print("There are error while adding company.\nTry Again!!!")
        }
    }
}
