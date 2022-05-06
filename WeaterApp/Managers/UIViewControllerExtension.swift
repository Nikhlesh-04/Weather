//
//  UIViewControllerExtension.swift
//  WeaterApp
//
//  Created by Mohnish on 06/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "WeatherApp", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (alerthandler) in
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
