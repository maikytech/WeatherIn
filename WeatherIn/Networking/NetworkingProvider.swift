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
    
//    private let kBaseUrl = "https://www.metaweather.com/api/location/"
//    private let kSearch = "search/?query="
    private let kStatusOk = 200...299
    
    func getCity(cityString: String, success: @escaping (_ city: [City]) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        //let url = "\(kBaseUrl)\(kSearch)\(cityString)"
        let url = "\(EndPoints.domain)\(EndPoints.search)\(cityString)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: [City].self) { response in
            
            if let city = response.value {
                success(city)
            }else {
                failure(response.error)
            }
            
        }
    }
    
    func getForecast(woeid: Int, success: @escaping (_ consolidatedWeather: [consolidatedWeather]) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        //let url = "\(kBaseUrl)\(kSearch)\(cityString)"
        let woeidString = String(woeid)
        let url = "\(EndPoints.domain)\(woeidString)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: Forecast.self, decoder: DateDecoder()) { response in
            
            if let consolidatedWeather = response.value?.consolidated_weather {
                success(consolidatedWeather)
                
            }else {
                failure(response.error)
                print("Error de Networking Forecast")
            }
            
        }
    }
    
}
