//
//  NetworkingProvider.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 2/06/21.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    private let kBaseUrl = "https://www.metaweather.com/api/location/"
    private let kSearch = "search/?query="
    private let kStatusOk = 200...299
    
    func getCity(cityString: String, success: @escaping (_ city: [City]) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = "\(kBaseUrl)\(kSearch)\(cityString)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: [City].self) { response in
            
            if let city = response.value {
                success(city)
            }else {
                failure(response.error)
            }
            
        }
    }
    
}
