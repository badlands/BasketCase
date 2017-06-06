//
//  RateProviderTests.swift
//  BasketCase
//
//  Created by Marco Marengo on 05/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import XCTest
@testable import BasketCase

class MockRateProvider: RateProvider {
    func change(_ localCurrency: Currency, into newCurrency: Currency, handler: @escaping RateProviderHandler) {
        handler(1.1, nil)
    }
}

class RateProviderTests: XCTestCase {
    let provider: RateProvider = MockRateProvider()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Change() {
        let expectation = XCTestExpectation()
        
        
        provider.change(.USD, into: .EUR) { (newValue, error) in
            XCTAssertNil(error)
            XCTAssertEqual(newValue, 1.1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
