//
//  NetworkError.swift
//  WeatherAppSwiftUI
//
//  Created by Sabri Sönmez on 10/3/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case noData
    case decodingError
    
    // can implement user friendly messages desired by design team
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid. Please try again."
        case .networkError(let error):
            return "Network error occurred: \(error.localizedDescription). Please check your connection and try again."
        case .invalidResponse:
            return "Invalid response from the server. Please make sure you entered the city name correct."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to decode the data."
        }
    }
}
