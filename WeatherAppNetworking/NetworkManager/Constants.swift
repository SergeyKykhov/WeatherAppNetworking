//
//  Constants.swift
//  WeatherAppNetworking
//
//  Created by Sergey Kykhov on 24.07.2023.
//

import Foundation
import UIKit

struct Constants {
    static let url = "https://api.openweathermap.org/data/2.5/weather"
    static let paramSpb = "?lat=59.57&lon=30.19&appid=\(Constants.API_KEY)"
    static let paramMoscow = "?lat=55.75&lon=37.61&appid=\(Constants.API_KEY)"

    static let API_KEY = "c517f261fefb1276ee794306f6a7031e"
}

