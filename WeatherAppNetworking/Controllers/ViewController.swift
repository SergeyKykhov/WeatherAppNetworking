//
//  ViewController.swift
//  WeatherAppNetworking
//
//  Created by Sergey Kykhov on 24.07.2023.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    //MARK: - Properties

    private let interface = ViewInterface()
    var weather: WeatherModel? = nil

    //MARK: - Methods Network URLSession

            private func requestWeatherData() {
                NetworkManager.shared.makeRequst(url: Constants.url, params: Constants.paramSpb) { [weak self] (result: WeatherModel?) in
                    guard let self = self, let weather = result else { return }
                    self.updateInterface(with: weather)
                }
            }

    //MARK: - Methods Network Alamofire

//    private func requestWeatherData() {
//        NetworkManager.shared.fetchData(url: Constants.url, params: Constants.paramSpb) { [weak self] (result: Result<WeatherModel, Error>) in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let weather):
//                self.updateInterface(with: weather)
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
//    }

    //MARK: - Formatted

    private func formattedTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    private func updateInterface(with weather: WeatherModel) {
        let temperatureCelsius = weather.main.temp - 273.15
        let humidityPercentage = weather.main.humidity
        let windSpeedMetersPerSecond = weather.wind.speed
        let feelsLikeCelsius = weather.main.feelsLike - 273.15
        let sunriseTime = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise))
        let sunsetTime = Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset))
        DispatchQueue.main.async {
            self.interface.temperatureLabel.text = "\(Int(temperatureCelsius.rounded())) °C"
            self.interface.humidityLabel.text = "\(Int(humidityPercentage)) %"
            self.interface.windSpeedLabel.text = "\(Int(windSpeedMetersPerSecond)) м/с"
            self.interface.feelsLikeLabel.text = "\(Int(feelsLikeCelsius.rounded())) °C"
            self.interface.sunriseTimeLabel.text = self.formattedTime(from: sunriseTime)
            self.interface.sunsetTimeLabel.text = self.formattedTime(from: sunsetTime)
        }
    }

    //MARK: - view lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(interface)
        setupLayout()
        requestWeatherData()
        interface.delegate = self
    }

    //MARK: - Constraints

    private func setupLayout() {
        interface.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

