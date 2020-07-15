//
//  CurrencyRateService.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 13/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

class CurrencyRateService {
    static var shared = CurrencyRateService()
    private init() {}

    private let currencyRateURL = URL(string: "http://data.fixer.io/api/latest")!

    private var currencyRateSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?

    var convertMoneyResult = Double()

    init(currencyRateSession: URLSession){
        self.currencyRateSession = currencyRateSession
    }

    func getCurrencyRate(callback: @escaping (Bool, CurrencyRate?) -> Void) {
        let request = createCurrencyRateRequest()

        task?.cancel()
        task = currencyRateSession.dataTask(with: request.url!) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return}
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return }
                guard let currency = try? JSONDecoder().decode(CurrencyRate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, currency)
            }
        }
        task?.resume()
    }

    private func createCurrencyRateRequest() -> URLComponents {
        var component = URLComponents(url: currencyRateURL, resolvingAgainstBaseURL: true)

        component?.queryItems = [URLQueryItem(name: "access_key", value: "6c7bb1f08a9dedd75e83976470ca57c6")]
        return component!
    }

    func convertMoney(with money: Double) -> Double {

        convertMoneyResult = money * 1.13215
        return convertMoneyResult
    }

}
