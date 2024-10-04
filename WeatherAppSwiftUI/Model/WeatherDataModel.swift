//
//  WeatherData.swift
//  WeatherAppSwiftUI
//
//  Created by Sabri Sönmez on 10/3/24.
//

import Foundation
struct WeatherDataModel: Codable {
    // based on openweather api json
    let main: Main
    let weather: [Weather]
    let name: String
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let description: String
        let icon: String
    }
}
