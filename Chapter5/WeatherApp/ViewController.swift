//
//  ViewController.swift
//  WeatherApp
//
//  Created by Surabhi Chopada on 13/10/2023.
//

import UIKit

class ViewController: UIViewController, WeatherViewDelegate {
    let locationManager = LocationManager()
    let apiManager = ApiManager()
    var weather: WeatherResponse?
    let weatherView = WeatherView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = weatherView
        weatherView.delegate = self
    }

    func didTapFetchWeather() {
        locationManager.requestLocation()
        Task {
            do {
                weather = try await apiManager.getWeather(latitude: locationManager.location?.latitude ?? 0, longitude:locationManager.location?.longitude ?? 0)
                weatherView.titleLabel.text = weather?.name
                weatherView.weatherLabel.text = weather?.weather[0].main
                weatherView.temperatureLabel.text = "Temp : \(weather?.main.temp ?? 0)°"
                weatherView.minMaxTempLabel.text = "Min: \(weather?.main.temp_min ?? 0)° Max: \(weather?.main.temp_max ?? 0)°"
                weatherView.windSpeedLabel.text = "Wind Speed : \(weather?.wind.speed ?? 0) m/s"
                weatherView.humidityLabel.text = "Humidity : " + String(weather?.main.humidity ?? 0) + " %"
                weatherView.activityIndicator.stopAnimating()
            } catch {
                print("Error getting weather: \(error)")
                weatherView.activityIndicator.stopAnimating()
            }
        }
    }
}

