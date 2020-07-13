//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

struct ExchangeRate {

    func convertMonay(with monay: Float) -> Float {
        var convertMonayResult: Float

        convertMonayResult = monay * 1.13215
        return convertMonayResult
    }

    private func exchangeService() {
        // appel reseau
    }
}
