//
//  WeatherViewModelTests.swift
//  WeatherAppSwiftUITests
//
//  Created by Sabri Sönmez on 10/4/24.
//

import XCTest
@testable import WeatherAppSwiftUI

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var networkManager: MockNetworkManager!

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = MockNetworkManager()
        viewModel = WeatherViewModel(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        networkManager = nil
        try super.tearDownWithError()
    }

    func testFetchWeatherSuccess() async {
        networkManager.mockWeatherData = WeatherDataModel(
            main: WeatherDataModel.Main(temp: 295.5),
            weather: [WeatherDataModel.Weather(description: "Clear sky", icon: "01d")],
            name: "New York"
        )

        await viewModel.fetchWeather(for: "New York")

        await MainActor.run { XCTAssertEqual(viewModel.city, "New York") }
        await MainActor.run { XCTAssertEqual(viewModel.temperature, "72°F") }
        await MainActor.run { XCTAssertEqual(viewModel.weatherDescription, "Clear sky") }
        await MainActor.run { XCTAssertNotNil(viewModel.iconURL) }
    }

    func testFetchWeatherFailure() async {
        networkManager.shouldReturnError = true

        await viewModel.fetchWeather(for: "InvalidCity")

        await MainActor.run { XCTAssertTrue(viewModel.showAlert) }
        await MainActor.run { XCTAssertEqual(viewModel.alertMessage, NetworkError.invalidResponse.errorMessage) }
    }
}
