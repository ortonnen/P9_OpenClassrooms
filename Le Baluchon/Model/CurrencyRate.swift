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

extension CurrencyRate {
    static func empty() -> CurrencyRate {
        return CurrencyRate(success: false, timestamp: 0, date: "", rates: ["" : 0])
    }
}

struct CurrencyExchange {


    func convertMoney(from originalCurrency: Double, to desiredCurrency: Double) -> Double {
        var result = Double()

        result = originalCurrency * desiredCurrency
        return result
    }
}


