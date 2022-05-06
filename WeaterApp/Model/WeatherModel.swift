//
//  WeatherModel.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit

class WeatherModel: Codable {

    var id:Int = 0
    var coord:Coord?
    var name:String = ""
    var main:Main?
    var weather:[Weather] = []
}

class Weather: Codable {
    var id:Int = 0
    var description:String = ""
}

class Coord: Codable {
    var lon:CGFloat = 0.0
    var lat:CGFloat = 0.0
}

class Main: Codable {
    var temp:CGFloat = 0.0
    var temp_min:CGFloat = 0.0
    var temp_max:CGFloat = 0.0
}



