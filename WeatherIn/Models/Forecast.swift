//
//  Forecast.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 3/06/21.
//

//{
//"id":5799125460189184,
//"weather_state_name":"Heavy Cloud",
//"weather_state_abbr":"hc",
//"wind_direction_compass":"WSW",
//"created":"2021-06-03T15:32:02.672129Z",
//"applicable_date":"2021-06-03",
//"min_temp":15.024999999999999,
//"max_temp":24.52,
//"the_temp":23.325000000000003,
//"wind_speed":5.620643022336222,
//"wind_direction":241.50343931867587,
//"air_pressure":1018.5,
//"humidity":58,
//"visibility":10.35297611946234,
//"predictability":71
//},

import Foundation

struct Forecast: Decodable {
    let title: String?
    let consolidated_weather: [consolidatedWeather]?
}

struct consolidatedWeather: Decodable {
    let weather_state_name: String?
    let weather_state_abbr: String?
    //let applicable_date: Date?
    let min_temp: Double
    let max_temp: Double
    let humidity: Int
}


