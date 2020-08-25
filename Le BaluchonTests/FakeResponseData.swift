//
//  FakeResponseData.swift
//  Le BaluchonTests
//
//  Created by Nathalie Ortonne on 24/08/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")!

        return (try? Data(contentsOf: url)) ?? Data()
    }

    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!

        return (try? Data(contentsOf: url)) ?? Data()
    }

    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!

        return (try? Data(contentsOf: url)) ?? Data()
    }

    static let incorrectData = "error".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://google.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://google.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!

    // MARK: - Error
    class FakeError: Error {}
    static let error = FakeError()
}
