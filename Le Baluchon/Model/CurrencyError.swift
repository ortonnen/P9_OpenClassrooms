//
//  CurrencyError.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 10/08/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

struct CurrencyError: Codable {
    var success: Bool
    var currencyError : ErrorResponse

}
    struct ErrorResponse: Codable {
        var code: Int
        var type: String
        var info: String
}
