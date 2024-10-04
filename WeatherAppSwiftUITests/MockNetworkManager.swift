//
//  MockNetworkManager.swift
//  WeatherAppSwiftUITests
//
//  Created by Sabri Sönmez on 10/4/24.
//

import Foundation
@testable import WeatherAppSwiftUI

class MockNetworkManager: NetworkManager {
    var mockWeatherData: WeatherDataModel?
    var shouldReturnError = false

    override func getWeather(for cityName: String) async throws -> WeatherDataModel {
        if shouldReturnError {
            throw NetworkError.invalidResponse
        }
        if let data = mockWeatherData {
            return data
        } else {
            throw NetworkError.noData
        }
    }

    override func getWeather(forLatitude latitude: Double, longitude: Double) async throws -> WeatherDataModel {
        if shouldReturnError {
            throw NetworkError.invalidResponse
        }
        if let data = mockWeatherData {
            return data
        } else {
            throw NetworkError.noData
        }
    }
}
