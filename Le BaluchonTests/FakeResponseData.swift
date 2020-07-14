//
//  FakeResponseCurrency.swift
//  Le BaluchonTests
//
//  Created by Nathalie Ortonne on 14/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
class FakeResponseData {

    let responseOk = HTTPURLResponse(url: URL(string: "https://https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseKO = HTTPURLResponse(url: URL(string: "https://https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class CurrencyRateError: Error {}
    let error = CurrencyRateError()

    var currencyCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CurrencyRate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let CurrencyIncorrectData = "erreur".data(using: .utf8)!

}
