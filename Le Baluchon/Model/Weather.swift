//
//  Weather.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

struct Weather: Decodable {

    var id: Int
    var main: String
    var description: String
}
