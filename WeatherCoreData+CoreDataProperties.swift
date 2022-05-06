//
//  WeatherCoreData+CoreDataProperties.swift
//  WeaterApp
//
//  Created by Nikhlesh on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherCoreData {

    @nonobjc public class func fetchRequests() -> NSFetchRequest<WeatherCoreData> {
        return NSFetchRequest<WeatherCoreData>(entityName: "WeatherCoreData")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var id: Int64
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?
    @NSManaged public var temp: Double
    @NSManaged public var temp_max: Double
    @NSManaged public var temp_min: Double
    @NSManaged public var insertTime: Date

}

extension WeatherCoreData : Identifiable {

}
