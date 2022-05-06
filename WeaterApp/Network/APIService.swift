//
//  APIService.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit

class APIService {

    func getWeather(lat:Double, long:Double, complition:((WeatherModel?, Error?) -> Void)?) {
        let urlString = "lat=\(lat)&lon=\(long)&appid=259584532b5ba74847a8db1ce42740b6"
        API.weather.request(objectType: WeatherModel.self, urlParameters: urlString) { (object, error) in
            if let weather = object {
                DispatchQueue.main.async {
                    complition?(weather,nil)
                }
            } else {
                complition?(nil,error)
            }
        }
    }
    
}
