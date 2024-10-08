# WeatherAppSwiftUI
# Weather App

## Overview
The Weather App is a simple application built using Swift and SwiftUI that allows users to check the current weather for a specified city or their current location. It makes use of the OpenWeather API to retrieve weather data and displays relevant information such as temperature, weather conditions, and an appropriate weather icon.

The app follows the MVVM (Model-View-ViewModel) architecture, ensuring a clean separation of responsibilities and easy testing. It also incorporates error handling, recent searches, and supports fetching weather data based on user location.

## Features
- **Search by City**: Enter the name of any city to view its current weather conditions.
- **Current Location Weather**: Fetch weather information based on the user's current geographic location.
- **Recent Searches**: View and quickly select from recent weather searches.
- **Error Handling**: Gracefully handle errors with user-friendly messages.
- **Loading State**: Display a loading indicator while weather data is being fetched.

## Technologies Used
- **Swift** and **SwiftUI**: For the app's UI and logic.
- **Combine**: Used for reactive programming and managing state changes.
- **OpenWeather API**: Provides real-time weather data.
- **CoreLocation**: For accessing user's current location.
- **XCTest**: Used for unit and UI testing.

## Project Structure
- **Model**: Defines the structure of weather data (`WeatherData` model).
- **ViewModel**: (`WeatherViewModel`) Manages the business logic and state of the app, including fetching data from the network and handling errors.
- **View**: (`WeatherView`) The SwiftUI view that displays the weather information, recent searches, and input fields.
- **NetworkManager**: Handles all API calls to OpenWeather and error handling.
- **LocationManager**: Manages location permissions and user location updates.

## Setup and Configuration
1. Clone the repository.
2. Open the project in Xcode.
3. Replace `YOUR_API_KEY` in the `NetworkManager` class with your API key from [OpenWeather](https://openweathermap.org/api).
4. Build and run the project on a simulator or physical device.

## Testing
This project includes unit and UI tests to ensure code quality and correct functionality.
- **Unit Tests**: Test the `WeatherViewModel` and `WeatherData` model.
- **Mock NetworkManager**: Provides mock responses for testing purposes.
- **UI Tests**: Verify user interface elements and interactions, such as searching for a city.

### Running Tests
To run the tests:
1. Open the project in Xcode.
2. Press `Cmd + U` to run all the unit and UI tests.

## How to Use
1. **Enter a City Name**: Type the name of a city in the text field and tap "Get Weather" to see the current weather information.
2. **Current Location**: Tap "Get Weather for Current Location" to retrieve weather data for your current geographical location (requires location permissions).
3. **Recent Searches**: Recent city searches are listed for easy access.

## Future Improvements
- **Localization**: Support multiple languages to enhance accessibility for a global audience.
- **Accessibility**: Improve support for accessibility features, such as VoiceOver.
- **Dark Mode Support**: Fully optimize the UI for dark mode.

## License
This project is licensed under the MIT License. Feel free to use and modify it as needed.

## Acknowledgements
- **OpenWeather** for providing the weather data.
- **Apple Developer Documentation** for SwiftUI and Combine resources.


