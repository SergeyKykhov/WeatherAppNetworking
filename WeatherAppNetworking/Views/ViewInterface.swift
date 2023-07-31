//
//  ViewInterface.swift
//  WeatherAppNetworking
//
//  Created by Sergey Kykhov on 24.07.2023.
//

import Foundation
import UIKit
import SnapKit

protocol ViewInterfaceDelegate: class {
    func didTapMoscowButton(completion: @escaping (String, String) -> Void)
    func didTapStPetersburgButton(completion: @escaping (String, String) -> Void)
    func requestWeatherData(for city: String, with params: String)
}

final class ViewInterface: UIView {

    weak var delegate: ViewInterfaceDelegate?

    // MARK: - Background effects

    let background: UIImageView = {
        let image = UIImage(named: "WeatherAppjpg")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func animateBackgroundBrightness() {
            UIView.animate(withDuration: 2, animations: {
                self.background.alpha = 1.0
            }) { _ in
                UIView.animate(withDuration: 2, animations: {
                    self.background.alpha = 0.6
                }) { _ in
                    self.animateBackgroundBrightness()
                }
            }
        }

    // MARK: - Labels

    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 90)
        label.textColor = .white
        return label
    }()

    let city: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.text = "St. Petersburg"
        return label
    }()

    let humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()

    let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()

    // MARK: - Icons

    let humidity: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        let humidityIcon = UIImage(systemName: "humidity")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: humidityIcon)
        stackView.addArrangedSubview(imageView)
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Влажность"
        stackView.addArrangedSubview(label)
        return stackView
    }()

    let windSpeed: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        let windIcon = UIImage(systemName: "wind")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: windIcon)
        stackView.addArrangedSubview(imageView)
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Ветер"
        stackView.addArrangedSubview(label)
        return stackView
    }()

    let feelsLike: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        let feelsLikeIcon = UIImage(systemName: "thermometer.medium")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: feelsLikeIcon)
        stackView.addArrangedSubview(imageView)
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Ощущается"
        stackView.addArrangedSubview(label)
        return stackView
    }()

    let sunriseTime: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        let sunriseTimeIcon = UIImage(systemName: "sunrise.circle")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 40))
        let imageView = UIImageView(image: sunriseTimeIcon)
        stackView.addArrangedSubview(imageView)
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Восход солнца"
        stackView.addArrangedSubview(label)
        return stackView
    }()

    let sunsetTime: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        let sunsetTimeIcon = UIImage(systemName: "sunset.circle")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 40))
        let imageView = UIImageView(image: sunsetTimeIcon)
        stackView.addArrangedSubview(imageView)
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Закат солнца"
        stackView.addArrangedSubview(label)
        return stackView
    }()

    //MARK: - Buttons

    let moscowButton: UIButton = {
        let moscowButton = UIButton()
        moscowButton.setTitle("Moscow", for: .normal)
        moscowButton.addTarget(self, action: #selector(moscowButtonTapped), for: .touchUpInside)
        moscowButton.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        moscowButton.layer.cornerRadius = 10
        moscowButton.setTitleColor(.white, for: .normal)
        return moscowButton
    }()

    @objc private func moscowButtonTapped() {
        delegate?.didTapMoscowButton(completion: { cityName, params in
            self.delegate?.requestWeatherData(for: cityName, with: params)
            self.city.text = cityName

            UIView.animate(withDuration: 0.3) {
                        self.moscowButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
                    }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        UIView.animate(withDuration: 0.3) {
                            self.moscowButton.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
                        }
                    }
        })
    }

    let spbButton: UIButton = {
        let spbButton = UIButton()
        spbButton.setTitle("St. Petersburg", for: .normal)
        spbButton.addTarget(self, action: #selector(spbButtonTapped), for: .touchUpInside)
        spbButton.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        spbButton.layer.cornerRadius = 10
        spbButton.setTitleColor(.white, for: .normal)
        return spbButton
    }()

    @objc private func spbButtonTapped() {
        delegate?.didTapStPetersburgButton(completion: { cityName, params in
            self.delegate?.requestWeatherData(for: cityName, with: params)
            self.city.text = cityName

            UIView.animate(withDuration: 0.3) {
                        self.spbButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
                    }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        UIView.animate(withDuration: 0.3) {
                            self.spbButton.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
                        }
                    }
        })
    }

    //MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    //MARK: - UI Setup

    private func setupUI() {
        animateBackgroundBrightness()
        addSubview(background)
        addSubview(temperatureLabel)
        addSubview(city)
        addSubview(humidity)
        addSubview(windSpeed)
        addSubview(feelsLike)
        addSubview(humidityLabel)
        addSubview(windSpeedLabel)
        addSubview(feelsLikeLabel)
        addSubview(sunriseTime)
        addSubview(sunsetTime)
        addSubview(sunriseTimeLabel)
        addSubview(sunsetTimeLabel)
        addSubview(moscowButton)
        addSubview(spbButton)
        createLayout()
    }

    //MARK: - Constraints

    func createLayout() {

        background.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        temperatureLabel.snp.makeConstraints {make in
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(200)
        }

        city.snp.makeConstraints {make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-30)

        }

        humidity.snp.makeConstraints {make in
            make.bottom.equalToSuperview().offset(-300)
            make.left.equalToSuperview().offset(30)
        }

        windSpeed.snp.makeConstraints {make in
            make.bottom.equalToSuperview().offset(-300)
            make.centerX.equalToSuperview()
        }

        feelsLike.snp.makeConstraints {make in
            make.bottom.equalToSuperview().offset(-300)
            make.right.equalToSuperview().offset(-30)
        }

        humidityLabel.snp.makeConstraints {make in
            make.top.equalTo(humidity.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(50)
        }

        windSpeedLabel.snp.makeConstraints {make in
            make.top.equalTo(windSpeed.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        feelsLikeLabel.snp.makeConstraints {make in
            make.top.equalTo(feelsLike.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-50)
        }

        sunriseTime.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
        }

        sunsetTime.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeLabel.snp.bottom).offset(40)
            make.right.equalToSuperview().offset(-30)
        }

        sunriseTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(sunriseTime.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(40)
        }

        sunsetTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(sunsetTime.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-40)
        }

        moscowButton.snp.makeConstraints { make in
            make.top.equalTo(city.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(100)
            make.height.equalTo(25)
        }

        spbButton.snp.makeConstraints { make in
            make.top.equalTo(city.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(150)
            make.height.equalTo(25)
        }
    }
}
