//
//  CurrencyTest.swift
//  Le BaluchonTests
//
//  Created by Nathalie Ortonne on 21/08/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class CurrencyTest: XCTestCase {
    var currencyExchange = CurrencyExchange()

    //MARK: CurrencyServicesTest
    func testGetCurrencyRateShouldPostFailedCallback() {

        let currencyRateService = CurrencyRateService(currencyRateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyRateService.getCurrencyRate { (success, currencyRate, currencyStatusCodeError, currencyError) in

            XCTAssertFalse(success)
            XCTAssertNil(currencyRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyRateShouldPostFailedCallbackIfNoData() {

        let currencyRateService = CurrencyRateService(currencyRateSession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyRateService.getCurrencyRate { (success, currencyRate, currencyStatusCodeError, currencyError) in

            XCTAssertFalse(success)
            XCTAssertNil(currencyRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyRateShouldPostFailedCallbackIfIncorrectResponse() {

        let currencyRateService = CurrencyRateService(currencyRateSession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyRateService.getCurrencyRate { (success, currencyRate, currencyStatusCodeError, currencyError) in

            XCTAssertFalse(success)
            XCTAssertNil(currencyRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyRateShouldPostFailedCallbackIfIncorrectData() {

        let currencyRateService = CurrencyRateService(currencyRateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyRateService.getCurrencyRate { (success, currencyRate, currencyStatusCodeError, currencyError) in

            XCTAssertFalse(success)
            XCTAssertNil(currencyRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }

    func testGetCurrencyRateShouldPostSuccessCallBackIfNoErrorAndCorrectData() {

                let currencyRateService = CurrencyRateService(currencyRateSession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyRateService.getCurrencyRate { (success, currencyRate, currencyStatusCodeError, currencyError) in

            XCTAssertTrue(success)
            XCTAssertNotNil(currencyRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //MARK: CurrencyExchangeTest

    func testGivenRateRecovered_WhenWishConvert_ThenConversionIsCorrect() {
        let euro = 10.00
        let Dollards = 1.1

        let currencyRate = currencyExchange.convertMoney(from: euro, to: Dollards)

        XCTAssertEqual(currencyRate, 11.0)
    }
}
