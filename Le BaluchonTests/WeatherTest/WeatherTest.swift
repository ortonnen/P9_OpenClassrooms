//
//  WeatherTest.swift
//  Le BaluchonTests
//
//  Created by Nathalie Ortonne on 21/08/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class WeatherTest: XCTestCase {
    
    var weatherTranslate = WeatherTranslate()

    //MARK: WeatherServiceTest - getWeather
    
    func testGetWeatherShouldPostFailedCallback() {
        
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error),
            imageSession: URLSessionFake(data:nil,response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(for: "Paris") { (success, weather, weatherImage, weatherError, weatherStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil),
            imageSession: URLSessionFake(data:nil,response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(for: "Paris") { (success, weather, weatherImage, weatherError, weatherStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil),
            imageSession: URLSessionFake(data:nil,response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(for: "Paris") { (success, weather, weatherImage, weatherError, weatherStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil),
            imageSession: URLSessionFake(data:nil,response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather(for: "Paris") { (success, weather, weatherImage, weatherError, weatherStatusCodeError) in
            
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedNotificationIfNoPictureData() {

        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil),
            imageSession: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: "Paris") { (success, weather, weatherImage, weatherError, weatherStatusCodeError) in

            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedNotificationIfIncorrectResponseWhileRetrievingPicture() {

        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil),
            imageSession: URLSessionFake(data: FakeResponseData.weatherImageData ,response: FakeResponseData.responseKO, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: "Paris") { (success, weather, weatherImage, weatherError, weatherStatusCodeError) in

            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil),
            imageSession: URLSessionFake(data:FakeResponseData.weatherCorrectData,response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: "Paris") { (success, weather, weatherImage, weatherError, weatherStatusCodeError) in

            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    //MARK: WeatherTranslateTest
    
    func testGivenSpeedIsRecovered_WhenWishConvertToKMPerHour_ThenConversionIsCorrect() {
        let windSpeed = weatherTranslate.windSpeedConvert(from: 0.45)
        
        XCTAssertEqual(windSpeed, 1.62)
    }
    
    func testGivenSunHourIsRecovered_WhenWishConvertToHourString_ThenConversionIsCorrect() {
        let sunHour = weatherTranslate.sunHourConvert(for: 1598246180)
        
        XCTAssertEqual(sunHour, "7:16 AM")
        
    }
    
    func testGivenDegreeToWindIsRecovered_WhenWishConvertToDirection_ThenConversionIsCorrect() {
        let windDirection = weatherTranslate.convertDegreeToWindDirection(for: 210)
        
        XCTAssertEqual(windDirection, "Sud")
    }
}
