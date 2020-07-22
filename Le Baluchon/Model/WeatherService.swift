//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 14/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

class WeatherService {
    static var shared = WeatherService()
    private init() {}

    private let weatherURL = URL(string: "http://data.fixer.io/api/latest")!

    private var weatherSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?

    init(weatherSession: URLSession){
        self.weatherSession = weatherSession

    }

    func getweather(for city: String, callback: @escaping (Bool, Weather?) -> Void) {
        let request = createWeatherRequest(for: city)

        task?.cancel()
        task = weatherSession.dataTask(with: request.url!) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return}
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return }
                guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, weather)
            }
        }
        task?.resume()
    }

    private func createWeatherRequest(for city: String) -> URLComponents {
        var component = URLComponents(url: weatherURL, resolvingAgainstBaseURL: true)

        component?.queryItems = [URLQueryItem(name: "q", value: "\(city)")]
        component?.queryItems = [URLQueryItem(name: "appid", value: "67d96eea07c431d9b5165f53ded7f9fd")]
        component?.queryItems = [URLQueryItem(name: "units", value: "metric")]
        component?.queryItems = [URLQueryItem(name: "lang", value: "fr")]
        return component!
    }

}
