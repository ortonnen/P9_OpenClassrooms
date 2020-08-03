//
//  Weather.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let name: String
    let weather: [WeatherCondition]
    let main : Temperature
    let wind: Wind
    let sys : Sys
}

struct WeatherCondition: Codable {
    var id: Int //(identifiant des condi météo)
    var main: String //(groupe de parametres météo: pluie, neige, extrème..)
    var description: String //(conditions météo au sein du groupe)
    var icon: String //(id icon météo)
}

struct Temperature: Codable {

    var temp: Double //(temperature mesure par defaut Kelvin/ metrique: celsius)
    var humidity: Int //(% d'humidité)
}

struct Wind: Codable {

    var speed: Double //(vit du vent unit par défaut m/s)
    var deg: Int //(direction du vent)
}

struct Sys: Codable {
    var type: Int //( parametre interne)
    var id: Int //( parametre interne)
    var country: String //( code du pays )
    var sunrise: Int //( heure du levé de soleil)
    var sunset: Int //(heure du coucher du soleil)
}

class WeatherTranslate {


    func windSpeedConvert(from meterPerSecond: Double) -> Double {
        return meterPerSecond * 3.6
    }

    func sunHourConvert(for hour: Int) -> String {
        let sunDate = Date(timeIntervalSince1970: TimeInterval(hour))
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium

        let formattedTime = formatter.string(from: sunDate)

        return formattedTime
    }

    func convertDegreeToWindDirection(for degrees: Int)-> String {
        var degree: Int
        let directions = ["Nord", "Nord-Est", "Est", "Sud-Est", "Sud", "Sud-Ouest", "Ouest", "Nord-Ouest"];

        degree = degrees * 8 / 360;

        degree = (degree + 8) % 8
        
        return directions[degree]
    }

}
