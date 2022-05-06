//
//  DetailViewController+TableView.swift
//  WeaterApp
//
//  Created by Nikhlesh on 07/05/22.
//  Copyright © 2022 Mohnish. All rights reserved.
//

import Foundation
import UIKit

extension DetailViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModel?.weathers.count ?? 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoicesTableViewCell.oldWeathers.rawValue, for: indexPath) as! OldWeatherCell
           
           if let model = self.weatherViewModel?.weathers[indexPath.row] {
               cell.setup(model: model)
           }
           
           return cell
       }
}

class OldWeatherCell : UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    func setup(model:WeatherCoreData) {
        self.name.text = model.name
        self.lat.text = "\(model.lat)"
        self.long.text = "\(model.lon)"
        self.descriptions.text = "\(model.descriptions ?? "")"
    }
}
