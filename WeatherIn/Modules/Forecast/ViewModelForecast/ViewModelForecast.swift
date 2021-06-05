//
//  ViewModelForecast.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 3/06/21.
//

import Foundation
import UIKit

class ViewModelForecast {
    var refreshData = {
        () -> () in
    }
    
    var dataSource:[consolidatedWeather] = [] {
        didSet {
            refreshData()
            
        }
    }
    
    func getForecast(woeid: Int) {
        
        NetworkingProvider.shared.getForecast(woeid: woeid) { (consolidatedWeather) in
            self.dataSource = consolidatedWeather
    
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}

