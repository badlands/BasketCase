//
//  Basket.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import Foundation

protocol BasketEntry {
    var product: Product { get }
    var quantity: Int { get }
}

protocol Basket {
    func add(_ product: Product, quantity: Int)
    
    func removeAll()
    func removeAll(_ product: Product)
    func remove(_ product: Product, quantity: Int)
    
    func update(_ product: Product, delta: Int)
    
    func totalPrice() -> Float
    func numberOfItems() -> Int
    func quantity(of product: Product) -> Int
    
    func entry(at index: Int) -> BasketEntry?
}
