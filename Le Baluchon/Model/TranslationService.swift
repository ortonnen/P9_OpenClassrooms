//
//  TranslationService.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 28/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation
//MARK: Enum error
enum TranslationError: Error {
    case dataError
    case responseError
    case translationError
    case codableError
}


//MARK: Enum mode to use API Translation
enum TranslationMode {
    case detectLanguage
    case translate

    //Methodes
    func getURL() -> URL {
        var urlString = URL(string: "")

        switch self {
        case .detectLanguage:
            urlString = URL(string:"https://translation.googleapis.com/language/translate/v2/detect")!

        case .translate:
            urlString = URL(string:"https://translation.googleapis.com/language/translate/v2")!
        }
        return urlString!
    }

}

//MARK: Translation Services
class TranslationService {

    static var shared = TranslationService()
    private init() {}

    // Proprieties
    var targetLanguageCode: String?

    private let apiKey = "AIzaSyA5JOHp16X8yo1epeghTZg4dQtnLJMC3eU"

    private var translationSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?

    init(translationSession: URLSession){
        self.translationSession = translationSession
    }
    // Methode
    private func createTranslationRequest(for translationMode: TranslationMode, use parameters:[String: String]) -> URLComponents {
        var component = URLComponents(url: translationMode.getURL(), resolvingAgainstBaseURL: true)

        component?.queryItems = [URLQueryItem]()

        for (key, value) in parameters {
            component?.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        return component!
    }
}
//MARK: Translate
extension TranslationService {

    func getTranslate(from originalLangue: String, to desiredLanguage: String, for text: String, callback: @escaping (Bool, Translate?, TranslationError?, TranslationStatusCodeError?)->Void){

        var parameters = [String: String]()
        parameters["key"] = apiKey
        parameters["q"] = text
        parameters["target"] = desiredLanguage
        parameters["source"] = originalLangue
        let request = createTranslationRequest(for: .translate, use: parameters)

        task?.cancel()
        task = translationSession.dataTask(with: request.url!) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, error == nil else {
                    callback(false, nil, .dataError, nil)
                    return }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    let responseStatusCodeError = try? JSONDecoder().decode(TranslationStatusCodeError.self, from: data)
                    callback(false, nil, .translationError, responseStatusCodeError)
                    return
                }
                guard let translation = try? JSONDecoder().decode(Translate.self, from: data) else {
                    callback(false, nil, .translationError, nil)
                    return
                }
                callback(true, translation, nil, nil)
            }
        }
        task?.resume()
    }

    //MARK: Detect Language

    func getDetectLanguage (for text: String, callback: @escaping (Bool, DetectLanguage?, TranslationError?, TranslationStatusCodeError?)->Void) {

        var parameters = [String: String]()
        parameters = ["key": apiKey, "q": text]

        let request = createTranslationRequest(for: .detectLanguage, use: parameters)

        task?.cancel()
        task = translationSession.dataTask(with: request.url!) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, error == nil else {
                    print("data")
                    callback(false, nil, .dataError, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("response")
                    let responseStatusCodeError = try? JSONDecoder().decode(TranslationStatusCodeError.self, from: data)
                    print(responseStatusCodeError?.message ?? "not here" )
                    print(responseStatusCodeError?.code ?? 999)
                    callback(false, nil, .translationError, responseStatusCodeError)
                    return
                }

                guard let detectLanguage = try? JSONDecoder().decode(DetectLanguage.self, from: data) else {
                    print("detectLaguage")
                    callback(false, nil, .translationError, nil)
                    return
                }
                callback(true, detectLanguage, nil, nil)
            }
        }
        task?.resume()
    }
}
