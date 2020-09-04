//
//  Weather.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
//MARK: Weather Codable
struct WeatherImage {
    var weatherImage: Data
}

struct Weather: Codable {
    let name: String
    let weather: [WeatherCondition]
    let main : Temperature
    let wind: Wind
    let sys : Sys
}

struct WeatherCondition: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Temperature: Codable {

    var temp: Double
    var humidity: Int
}

struct Wind: Codable {

    var speed: Double
    var deg: Int 
}

struct Sys: Codable {
    
    var sunrise: Int
    var sunset: Int
}

//MARK: Status Code Error
struct WeatherStatusCodeError: Codable {
    let message: String
}

//MARK: Weather Conversion
struct WeatherTranslate {

    ///convert meter per second to kilometer per hour
    func windSpeedConvert(from meterPerSecond: Double) -> Double {
        return meterPerSecond * 3.6
    }

    ///convert hour to format 3:30 PM
    func sunHourConvert(for hour: Int) -> String {
        let sunDate = Date(timeIntervalSince1970: TimeInterval(hour))
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short

        let formattedTime = formatter.string(from: sunDate)

        return formattedTime
    }

    /// convert degree to direction
    func convertDegreeToWindDirection(for degrees: Int)-> String {
        var degree: Int
        let directions = ["Nord", "Nord-Est", "Est", "Sud-Est", "Sud", "Sud-Ouest", "Ouest", "Nord-Ouest"];

        degree = degrees * 8 / 360;

        degree = (degree + 8) % 8
        
        return directions[degree]
    }

}
