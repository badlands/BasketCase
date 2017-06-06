//
//  LocalBasketTests.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import XCTest
@testable import BasketCase

class LocalBasketTests: XCTestCase {
    var basket: Basket!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        basket = LocalBasket()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_AddProduct() {
        let product = PeaProduct()
        basket.add(product, quantity: 10)
        
        XCTAssertEqual(1, basket.numberOfItems())
    }

    func test_RemoveProduct() {
        let product = PeaProduct()
        basket.add(product, quantity: 10)
        XCTAssertEqual(1, basket.numberOfItems())
        basket.remove(product, quantity: 5)
        XCTAssertEqual(1, basket.numberOfItems())
        XCTAssertEqual(5, basket.quantity(of: product))
        
        // are there side effects?
        let nonInBasketProduct = BeanProduct()
        basket.remove(nonInBasketProduct, quantity: 100)
        XCTAssertEqual(5, basket.quantity(of: product))
        XCTAssertEqual(0, basket.quantity(of: nonInBasketProduct))
    }
    
    func test_RemoveAllProduct() {
        let product = PeaProduct()
        let product2 = BeanProduct()
        basket.add(product, quantity: 10)
        basket.add(product2, quantity: 10)
        XCTAssertEqual(2, basket.numberOfItems())
        basket.removeAll(product)
        XCTAssertEqual(1, basket.numberOfItems())
        
    }
    
    func test_RemoveAll() {
        let product = PeaProduct()
        let product2 = BeanProduct()
        basket.add(product, quantity: 10)
        basket.add(product2, quantity: 10)
        XCTAssertEqual(2, basket.numberOfItems())
        basket.removeAll()
        XCTAssertEqual(0, basket.numberOfItems())
    }
    
    func test_UpdateProduct() {
        let product = PeaProduct()
        basket.add(product, quantity: 10)
        XCTAssertEqual(10, basket.quantity(of: product))
        basket.update(product, delta: 5)
        XCTAssertEqual(15, basket.quantity(of: product))
        basket.update(product, delta: -5)
        XCTAssertEqual(10, basket.quantity(of: product))
    }
    
    
    func test_TotalPrice() {
        let product = PeaProduct()
        basket.add(product, quantity: 1)
        XCTAssertEqual(product.price, basket.totalPrice())
        
        let product2 = BeanProduct()
        basket.add(product2, quantity: 10)
        let expectedPrice = product.price + product2.price * 10
        XCTAssertEqual(expectedPrice, basket.totalPrice())        
    }
    
    func test_QuantityOfProduct() {
        let product = PeaProduct()
        basket.add(product, quantity: 99)
        XCTAssertEqual(99, basket.quantity(of: product))
    }
    
    func test_NumberOfItems() {
        XCTAssertEqual(0, basket.numberOfItems())
        
        let product = PeaProduct()
        basket.add(product, quantity: 1)
        XCTAssertEqual(1, basket.numberOfItems())
    }
    
}
