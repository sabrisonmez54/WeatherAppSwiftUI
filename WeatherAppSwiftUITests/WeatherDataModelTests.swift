//
//  WeatherDataModelTests.swift
//  WeatherAppSwiftUITests
//
//  Created by Sabri Sönmez on 10/4/24.
//

import XCTest
@testable import WeatherAppSwiftUI

class WeatherDataModelTests: XCTestCase {
    func testWeatherDataDecoding() throws {
        // could place this ina folder with more fake json for each model
        let json = """
        {
            "main": {
                "temp": 85.0
            },
            "weather": [
                {
                    "description": "sunny",
                    "icon": "01d"
                }
            ],
            "name": "Los Angeles"
        }
        """.data(using: .utf8)!

        let decodedData = try JSONDecoder().decode(WeatherDataModel.self, from: json)

        XCTAssertEqual(decodedData.name, "Los Angeles")
        XCTAssertEqual(decodedData.main.temp, 85.0)
        XCTAssertEqual(decodedData.weather.first?.description, "sunny")
        XCTAssertEqual(decodedData.weather.first?.icon, "01d")
    }

    func testWeatherDataDecodingFailure() throws {
        let json = """
        {
            "main": {
                "temperature": 85.0
            },
            "weather": []
        }
        """.data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(WeatherDataModel.self, from: json))
    }
}
