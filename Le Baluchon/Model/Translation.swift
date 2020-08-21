//
//  Translation.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import Foundation

//MARK: Translate
struct Translate: Codable {
    let data: Translations
}

struct Translations: Codable {
    let translations: [Translated]
}

struct Translated: Codable {
    let translatedText: String
}

//MARK: Detected Langage
struct DetectLanguage: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let detections: [[Detection]]
}

struct Detection: Codable {

    let isReliable: Bool
    let language: String
}


//MARK: Supported Languages
struct SupportedLanguages: Codable {
    let data: Languages
}

struct Languages: Codable {
    let languages: [ReferencedLanguage]
}

struct ReferencedLanguage: Codable{
    let language: String
    let name: String
}

//MARK: Error
struct TranslationStatusCodeError: Codable {
    let code : Int
    let message: String
}
