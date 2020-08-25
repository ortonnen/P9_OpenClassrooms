//
//  TranslationTest.swift
//  Le BaluchonTests
//
//  Created by Nathalie Ortonne on 21/08/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class TranslationTest: XCTestCase {
    
    //MARK: TranslationServiceTest
    
    func testGetTranslationShouldPostFailedCallback() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslate(from: "fr", to: "en", for: "bonjour") { (success, translate, translationError, translationStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslate(from: "fr", to: "en", for: "bonjour") { (success, translate, translationError, translationStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslate(from: "fr", to: "en", for: "bonjour") { (success, translate, translationError, translationStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslate(from: "fr", to: "en", for: "bonjour") { (success, translate, translationError, translationStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslate(from: "fr", to: "en", for: "bonjour") { (success, translate, translationError, translationStatusCodeError) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectedLanguageShouldPostFailedCallback() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getDetectLanguage(for: "Bonjour") { (success, detectLanguage, translationError, translationStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(detectLanguage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectedLanguageShouldPostFailedCallbackIfNoData() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getDetectLanguage(for: "Bonjour") { (success, detectLanguage, translationError, translationStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(detectLanguage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectedLanguageShouldPostFailedCallbackIfIncorrectResponse() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getDetectLanguage(for: "Bonjour") { (success, detectLanguage, translationError, translationStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(detectLanguage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectedLanguageShouldPostFailedCallbackIfIncorrectData() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getDetectLanguage(for: "Bonjour") { (success, detectLanguage, translationError, translationStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(detectLanguage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetectedLanguageShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        
        let translationService = TranslationService(
            translationSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getDetectLanguage(for: "Bonjour") { (success, detectLanguage, translationError, translationStatusCodeError) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(detectLanguage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
