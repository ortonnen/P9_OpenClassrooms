//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

struct ExchangeRate {

    func convertMoney(with money: Float) -> Float {
        var convertMoneyResult: Float

        convertMoneyResult = money * 1.13215
        return convertMoneyResult
    }

    private func exchangeService() {
        // appel reseau
    }
}
