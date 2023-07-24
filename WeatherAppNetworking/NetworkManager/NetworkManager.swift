//
//  NetworkManager.swift
//  WeatherAppNetworking
//
//  Created by Sergey Kykhov on 24.07.2023.
//

import Foundation
import UIKit

final class NetworkManager {

    func makeRequst(url: String, params: String, complition: @escaping (WeatherModel) -> Void) {
        guard let completeUrl = URL(string: url + params) else {
            fatalError("ERROR")
        }
        var request = URLRequest(url: completeUrl)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, respons, error in
            if let error = error {
                print(error)
            }
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Responce: \(jsonString)")
                } else {
                    print("Error decoding JSON")
                }

                do {
                    let json = try JSONDecoder().decode(WeatherModel.self, from: data)
                    complition(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
