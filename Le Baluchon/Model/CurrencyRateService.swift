//
//  CurrencyRateService.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 13/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

enum CurrencyRateError: Error {
    case dataError
    case responseError
    case currencyError
}

class CurrencyRateService {
    static var shared = CurrencyRateService()
    private init() {}

    private let currencyRateURL = URL(string: "http://data.fixer.io/api/latest")!

    private var currencyRateSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?

    init(currencyRateSession: URLSession){
        self.currencyRateSession = currencyRateSession
    }

    func getCurrencyRate(callback: @escaping (Bool, CurrencyRate?, CurrencyStatusCodeError?, CurrencyRateError?) -> Void) {
        let request = createCurrencyRateRequest()

        task?.cancel()
        task = currencyRateSession.dataTask(with: request.url!) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil, nil, .dataError)
                    return}
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    let responseStatusCodeError = try?JSONDecoder().decode(CurrencyStatusCodeError.self, from: data)
                    callback(false, nil, responseStatusCodeError, .responseError)
                    return}
                guard let currency = try? JSONDecoder().decode(CurrencyRate.self, from: data) else {
                    callback(false, nil, nil, .currencyError)
                    return
                }
                callback(true, currency, nil, nil)
            }
        }
        task?.resume()
    }

    private func createCurrencyRateRequest() -> URLComponents {
        var component = URLComponents(url: currencyRateURL, resolvingAgainstBaseURL: true)

        component?.queryItems = [URLQueryItem(name: "access_key", value: "6c7bb1f08a9dedd75e83976470ca57c6")]
        return component!
    }

}
