//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Surabhi Chopada on 18/10/2023.
//

import Foundation
import UIKit

protocol WeatherViewDelegate: AnyObject {
    func didTapFetchWeather()
}

class WeatherView: UIView {
    weak var delegate: WeatherViewDelegate?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather App"
        label.font = UIFont.systemFont(ofSize: 36)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "25°C"
        label.font = UIFont.systemFont(ofSize:36)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let minMaxTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Min: 20°C  Max: 30°C"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "Wind Speed: 5 m/s"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "Humidity: 65%"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let fetchWeatherButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Weather", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    @objc private func fetchWeather() {
        activityIndicator.startAnimating()
        delegate?.didTapFetchWeather()
    }

    private func setupUI() {
        self.backgroundColor = .brown
        addSubview(titleLabel)
        addSubview(weatherLabel)
        addSubview(temperatureLabel)
        addSubview(minMaxTempLabel)
        addSubview(windSpeedLabel)
        addSubview(humidityLabel)
        addSubview(fetchWeatherButton)
        addSubview(activityIndicator)

        // Layout constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

            weatherLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),

            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),

            minMaxTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            minMaxTempLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),

            windSpeedLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            windSpeedLabel.topAnchor.constraint(equalTo: minMaxTempLabel.bottomAnchor, constant: 10),

            humidityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            humidityLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 10),

            fetchWeatherButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            fetchWeatherButton.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20),
            fetchWeatherButton.widthAnchor.constraint(equalToConstant: 150),
            fetchWeatherButton.heightAnchor.constraint(equalToConstant: 50),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        fetchWeatherButton.addTarget(self, action: #selector(fetchWeather), for: .touchUpInside)
    }
}
