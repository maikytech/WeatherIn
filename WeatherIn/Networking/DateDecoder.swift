//
//  DateDecoder.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 4/06/21.
//

//"applicable_date":"2021-06-03"

import Foundation

final class DateDecoder: JSONDecoder {
    
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    
}
