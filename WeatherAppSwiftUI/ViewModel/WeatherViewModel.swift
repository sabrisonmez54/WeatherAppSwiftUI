//
//  WeatherViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Sabri Sönmez on 10/3/24.
//

import Foundation
import UIKit

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var weatherDescription: String = ""
    @Published var temperature: String = ""
    @Published var iconURL: URL?
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var recentSearches: [String] = []
    @Published var isLoading = false
    
    private let networkManager: NetworkManager
    private let userDefaults = UserDefaults.standard
    private let lastCityKey = "lastSearchedCity"
    private let recentSearchesKey = "recentSearches"
    
    // can implement caching here with more time for optimization

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        loadLastSearchedCity()
        loadRecentSearches()
    }

    // Fetch weather data for a city by name

    func fetchWeather(for cityName: String) async {
        isLoading = true
        do {
            let data = try await networkManager.getWeather(for: cityName)
            updateWeatherData(data)
            saveLastSearchedCity(cityName)
            addRecentSearch(cityName)
        } catch let error as NetworkError {
            handleError(error)
        } catch {
            handleError(NetworkError.networkError(error))
        }
        isLoading = false
    }

    // Fetch weather data for a location by coordinates
    
    func fetchWeather(forLatitude latitude: Double, longitude: Double) async {
        isLoading = true
        do {
            print("Fetching weather for coordinates: \(latitude), \(longitude)")
            let data = try await networkManager.getWeather(forLatitude: latitude, longitude: longitude)
            updateWeatherData(data)
        } catch let error as NetworkError {
            handleError(error)
        } catch {
            handleError(NetworkError.networkError(error))
        }
        isLoading = false
    }

    // Update the view model properties with the fetched weather data

    private func updateWeatherData(_ data: WeatherDataModel) {
        city = data.name
        if data.main.temp.isNaN {
            temperature = "N/A"
        } else {
            let fahrenheitTemp = (data.main.temp - 273.15) * 9/5 + 32
            temperature = "\(Int(fahrenheitTemp))°F"
        }
        weatherDescription = data.weather.first?.description ?? ""
        if let icon = data.weather.first?.icon {
            iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        }
    }

    // save to user defaulft last searched cities
    
    private func saveLastSearchedCity(_ cityName: String) {
        userDefaults.set(cityName, forKey: lastCityKey)
    }

    private func loadLastSearchedCity() {
        if let savedCity = userDefaults.string(forKey: lastCityKey) {
            Task {
                await fetchWeather(for: savedCity)
            }
        }
    }

    private func addRecentSearch(_ cityName: String) {
        if !recentSearches.contains(cityName) {
            recentSearches.append(cityName)
            if recentSearches.count > 5 {
                recentSearches.removeFirst()
            }
            saveRecentSearches()
        }
    }

    private func saveRecentSearches() {
        userDefaults.set(recentSearches, forKey: recentSearchesKey)
    }

    private func loadRecentSearches() {
        if let savedSearches = userDefaults.array(forKey: recentSearchesKey) as? [String] {
            recentSearches = savedSearches
        }
    }

    // error handling
    
    private func handleError(_ error: NetworkError) {
        alertMessage = error.errorMessage
        showAlert = true
    }
}
