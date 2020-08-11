//
//  TranslationService.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 28/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

enum TranslationError: Error {
    case dataError
    case responseError
    case translationError
}

class TranslationService {
    static var shared = TranslationService()
    private init() {}

    private let translationURL = URL(string: "")!

    private var translationSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?

    init(translationSession: URLSession){
        self.translationSession = translationSession

    }

    func getTranslation(for city: String, callback: @escaping (Bool, Translation?, TranslationError?) -> Void) {
        let request = createTranslationRequest()

        task?.cancel()
        task = translationSession.dataTask(with: request.url!) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil, .dataError)
                    return}

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil, .responseError)
                    return }
                guard let translation = try? JSONDecoder().decode(Translation.self, from: data) else {
                    callback(false, nil, .translationError)
                    return
                }
                callback(true, translation, nil)
            }
        }
        task?.resume()
    }

    private func createTranslationRequest() -> URLComponents {
        var component = URLComponents(url: translationURL, resolvingAgainstBaseURL: true)

        component?.queryItems = [URLQueryItem(name: "", value: "")]
        return component!
    }

}
