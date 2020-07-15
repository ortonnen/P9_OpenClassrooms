//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

struct CurrencyRate: Decodable {

    var success: Bool
    var timestamp: Int
    var date: String
    var rates: [String: Double]

}
