//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 14/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case dataError
    case responseError
    case weatherError
}

class WeatherService {
    static var shared = WeatherService()
    private init() {}
    
    private let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather")!

    private let imageSession = URLSession(configuration: .default)
    private var weatherSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?
    
    init(weatherSession: URLSession){
        self.weatherSession = weatherSession
        
    }
    
    func getweather(for city: String, callback: @escaping (Bool, Weather?, WeatherImage?, WeatherError?, WeatherStatusCodeError?) -> Void) {
        let request = createWeatherRequest(for: city)
        
        task?.cancel()
        task = weatherSession.dataTask(with: request.url!) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data else {
                    print("data")
                    callback(false, nil, nil, .dataError, nil )
                    return}

                guard error == nil else {
                    print("error")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("response")
                    let responseStatusCodeError = try? JSONDecoder().decode(WeatherStatusCodeError.self, from: data)
                    callback(false, nil, nil, .responseError, responseStatusCodeError)
                    return
                }

                guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                    print("weather")
                    callback(false, nil, nil, .weatherError, nil)
                    return
                }
                self.getImage(for: weather.weather[0].icon) { (data, weatherError, weatherStatusCodeError) in
                    guard let data = data else {
                        callback(false, nil, nil, .dataError, nil)
                        return
                    }
                    let weatherImage = WeatherImage.init(weatherImage: data)
                    
                    callback(true, weather, weatherImage, nil, nil)
                }

            }
        }
        task?.resume()
    }
    
    private func createWeatherRequest(for city: String) -> URLComponents {
        var component = URLComponents(url: weatherURL, resolvingAgainstBaseURL: true)
        
        component?.queryItems = [URLQueryItem(name: "q", value: "\(city)"),
                                 URLQueryItem(name: "appid", value: "67d96eea07c431d9b5165f53ded7f9fd"),
                                 URLQueryItem(name: "units", value: "metric"),
                                 URLQueryItem(name: "lang", value: "fr")]
        return component!
    }

    func getImage(for weather: String, callback: @escaping (Data?, WeatherError?, WeatherStatusCodeError?) -> Void) {
        let weatherPictureURL = URL(string: "http://openweathermap.org/img/wn/\(weather)@2x.png")!

        task?.cancel()
        task = imageSession.dataTask(with: weatherPictureURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(nil, .dataError, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("response")
                    let responseStatusCodeError = try? JSONDecoder().decode(WeatherStatusCodeError.self, from: data)
                    callback(nil, .responseError, responseStatusCodeError)
                    return
                }
                callback(data, nil, nil)
            }
        }
        task?.resume()
    }
}
