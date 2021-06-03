//
//  ViewController.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 2/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCity()
    }
    
    func getCity() {
        
        NetworkingProvider.shared.getCity(cityString: "san") { (city) in
            print(city)
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}

