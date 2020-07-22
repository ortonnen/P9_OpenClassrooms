//
//  Weather.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    let name: String
    let weatherCondition: WeatherCondition
    let temperature : Temperature
    let wind: Wind
    let sys : Sys
}

struct WeatherCondition: Decodable {

    var id: Int //(identifiant des condi météo)
    var main: String //(groupe de parametres météo: pluie, neige, extrème..)
    var description: String //(conditions météo au sein du groupe)
    var icon: String //(id icon météo)
}

struct Temperature: Decodable {

    var temp:Float //(temperature mesure par defaut Kelvin/ metrique: celsius)
    var humidity: Int //(% d'humidité)
}

struct Wind: Decodable {

    var speed: Double //(vit du vent unit par défaut m/s)
    var deg: Int //(direction du vent)
}

struct Sys: Decodable {
    var type: Int //( parametre interne)
    var id: Int //( parametre interne)
    var country: String //( code du pays )
    var sunrise: Int //( heure du levé de soleil)
    var sunset: Int //(heure du coucher du soleil)
}
