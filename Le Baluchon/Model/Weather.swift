//
//  Weather.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    /*
Localisatopn géographique longitude/ latitude
     coord:
        lat:float
        long:float

info sur les conditions météorologiques
     weather:
        id: Int (identifiant des condi météo)
        main: String (groupe de parametres météo: pluie, neige, extrème..)
        description: String (conditions météo au sein du groupr 15/fr/Français)
        icon: String (id icon météo)

parametre interne
     base: String

     main:
        temp:Float (temperature mesure par defaut Kelvin/ metrique: celsius)
        feels_like: Float (temperature/ perception humaine)
        temp_min: Float (temp minimal en ce moment)
        temp_max: Float (temp max en ce moment)
        pressure: Int (pression atmospherique)
        humidity: Int (% d'humidité)

     visibility: Int


     wind:
        speed: Double (vit du vent unit par défaut m/s)
        deg: Int (direction du vent)


     clouds:
        all: Int ( % de nébulosité)

heure du calcul de données
     dt: Float

     sys:
        type: Int ( parametre interne)
        id: Int ( parametre interne)
        country: String ( code du pays )
        sunrise: Int ( heure du levé de soleil)
        sunset: Int (heure du coucher du soleil)

décalageen quelques secondes depuis UTC
     timezone: Int

identifiant de la ville
     id: Int

nom de la ville
     name: String

parametre interne
     cod: Int

     */

}

struct LocalWeather {
    
}
