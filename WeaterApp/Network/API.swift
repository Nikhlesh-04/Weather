//
//  API.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit

enum API:String {
    case weather = "weather"
}

extension API:APIRequirement {
    static var baseURL: String {
        return URLS.baseURL.rawValue
    }
    
    var apiHeader: [String : String] {
        return Constants.kheader
    }
    
    var apiPath: String {
        return "\(API.baseURL)"
    }
    
    var apiMethod: String {
        return self.rawValue
    }
}
