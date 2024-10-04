//
//  WeatherView.swift
//  WeatherAppSwiftUI
//
//  Created by Sabri Sönmez on 10/3/24.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @StateObject var locationManager = LocationManager()
    
    @State private var cityName: String = ""
    
    var body: some View {
        ZStack {
            // background gradient
            
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // TextField to enter the city name
                    
                    TextField("Enter city name", text: $cityName)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .accessibilityLabel(Text("City Name"))
                    
                    // display recent searches if available
                    
                    if !viewModel.recentSearches.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Recent Searches:")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.leading)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.recentSearches, id: \..self) { city in
                                        Button(action: {
                                            Task {
                                                await viewModel.fetchWeather(for: city)
                                            }
                                        }) {
                                            Text(city)
                                                .padding(.horizontal)
                                                .padding(.vertical, 5)
                                                .background(Color.white.opacity(0.8))
                                                .cornerRadius(10)
                                                .foregroundColor(.blue)
                                        }
                                        .accessibilityLabel(Text("Recent Search: \(city)"))
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // button to fetch weather for the desired city
                    
                    Button(action: {
                        Task {
                            await viewModel.fetchWeather(for: cityName)
                        }
                    }) {
                        Text("Get Weather")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(cityName.isEmpty)
                    .padding(.horizontal)
                    .accessibilityLabel(Text("Fetch Weather for City"))
                    
                    // button to fetch weather for current location
                    
                    Button(action: {
                        if let location = locationManager.userLocation {
                            Task {
                                await viewModel.fetchWeather(forLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                            }
                        }
                    }) {
                        Text("Get Weather for Current Location")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .accessibilityLabel(Text("Fetch Weather for Current Location"))
                    
                    // display weather info
                    
                    if !viewModel.city.isEmpty {
                        VStack(spacing: 10) {
                            Text(viewModel.city)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                            
                            Text(viewModel.weatherDescription)
                                .font(.title2)
                                .foregroundColor(.white)
                            
                            // display the weather icon if available
                            
                            if let iconURL = viewModel.iconURL {
                                AsyncImage(url: iconURL) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                            }

                            Text(viewModel.temperature)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding()
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            if locationManager.authorizationStatus == .notDetermined {
                locationManager.requestLocationAccess()
            }
        }
    }
}
