//
//  ContentView.swift
//  WeatherAppSwiftUI
//
//  Created by Sabri Sönmez on 10/3/24.
//

import SwiftUI

// Step 6: Create the ContentView
struct ContentView: View {
    var body: some View {
        NavigationView {
            let networkManager = NetworkManager()
            let viewModel = WeatherViewModel(networkManager: networkManager)
            WeatherView(viewModel: viewModel)
                .navigationTitle("Weather App")
        }
    }
}

#Preview {
    ContentView()
}
