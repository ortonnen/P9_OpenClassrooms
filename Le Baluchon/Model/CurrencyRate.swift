//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

//MARK: Currency Codable
struct CurrencyRate: Codable {

    var success: Bool
    var timestamp: Int
    var date: String
    var rates: [String: Double]
}

//MARK: Currency Status Code Error
struct CurrencyStatusCodeError: Codable {
    var success: Bool
    var currencyError : ErrorResponse

}

struct ErrorResponse: Codable {
    var code: Int
    var type: String
    var info: String
}

//MARK: Currency Rate
extension CurrencyRate {

    static func empty() -> CurrencyRate {
        return CurrencyRate(success: false, timestamp: 0, date: "", rates: ["" : 0])
    }
}

//MARK: Currency convert
struct CurrencyExchange {

    ///methode to convert money
    func convertMoney(from originalCurrency: Double, to desiredCurrency: Double) -> Double {
        var result = Double()

        result = originalCurrency * desiredCurrency
        return result
    }
}


