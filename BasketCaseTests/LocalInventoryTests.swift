//
//  LocalInventoryTests.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import XCTest
@testable import BasketCase

class LocalInventoryTests: XCTestCase {
    let inventory: Inventory = LocalInventory()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_GetAllProducts() {
        let products = inventory.availableProducts()
        XCTAssertEqual(4, products.count)
    }
    
}
