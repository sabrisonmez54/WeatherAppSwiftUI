//
//  NetworkManager.swift
//  WeatherAppSwiftUI
//
//  Created by Sabri Sönmez on 10/3/24.
//

import Foundation

class NetworkManager {
    private let apiKey = "1b506fabc2b96e94873a94f81d5923e8"  // Replace with your actual API key

    // optimize performance by using singleton url session
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    // Fetch weather data for a specific city by name

    func getWeather(for cityName: String) async throws -> WeatherDataModel {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)") else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let weatherData = try JSONDecoder().decode(WeatherDataModel.self, from: data)
            return weatherData
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // Fetch weather data for a specific location by latitude and longitude
    
    func getWeather(forLatitude latitude: Double, longitude: Double) async throws -> WeatherDataModel {
          guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)") else {
              throw NetworkError.invalidURL
          }

          let (data, response) = try await URLSession.shared.data(from: url)

          guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
              throw NetworkError.invalidResponse
          }

          do {
              let weatherData = try JSONDecoder().decode(WeatherDataModel.self, from: data)
              return weatherData
          } catch {
              throw NetworkError.decodingError
          }
      }
}
