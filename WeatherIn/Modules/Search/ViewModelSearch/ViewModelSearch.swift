//
//  ViewModelSearch.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 2/06/21.
//

import Foundation

class ViewModelSearch {
    
    var refreshData = {
        () -> () in
    }
    
    var dataSource:[City] = [] {
        didSet {
            refreshData()
            
        }
    }
    
    func getCity(cityString: String) {
        
        NetworkingProvider.shared.getCity(cityString: cityString) { (city) in
            self.dataSource = city
            
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}
