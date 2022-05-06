//
//  Constants.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit

struct Constants {

    static let kheader = ["Content-Type":"application/json"]
    
}

enum URLS:String {
    case baseURL = "https://api.openweathermap.org/data/2.5/"
}

enum InvoicesTableViewCell:String {
    case oldWeathers = "oldWeathersCell"
}
