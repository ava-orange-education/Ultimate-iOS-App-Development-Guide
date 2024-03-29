//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Surabhi Chopada on 17/10/2023.
//

import Foundation
import CoreLocation

class ApiManager {
    let API_Key = "6d98913ecfe07cd129c6d447735355cf"
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponse {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API_Key)&units=metric")
        else {
            fatalError("Invalid URL")
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching data")
        }
        let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return weatherData
    }
}
