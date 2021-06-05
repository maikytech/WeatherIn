//
//  ViewModelSearch.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 2/06/21.
//

import Foundation
import UIKit

class ViewModelSearch {
    
    var activityIndicator:UIActivityIndicatorView?
    
    var refreshData = {
        () -> () in
    }
    
    var dataSource:[City] = [] {
        didSet {
            refreshData()
            
        }
    }
    
    func getCity(cityString: String, activityIndicator: UIActivityIndicatorView) {
        
        NetworkingProvider.shared.getCity(cityString: cityString) { (city) in
            self.dataSource = city
            self.activityIndicator = activityIndicator
            activityIndicator.stopAnimating()
            
            
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}
