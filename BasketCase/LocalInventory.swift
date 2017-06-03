//
//  LocalInventory.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import Foundation

struct PeaProduct: Product {
    let productId = "peas"
    let name = "Peas"
    let price: Float = 0.95
    let unit = ProductUnit.bag
}

struct EggProduct: Product {
    let productId = "eggs"
    let name = "Eggs"
    let price: Float = 2.10
    let unit = ProductUnit.dozen
}

struct MilkProduct: Product {
    let productId = "milk"
    let name = "Fresh milk"
    let price: Float = 1.3
    let unit = ProductUnit.bottle
}

struct BeanProduct: Product {
    let productId = "beans"
    let name = "Beans"
    let price: Float = 0.73
    let unit = ProductUnit.can
}

class LocalInventory: Inventory {
    func availableProducts() -> [Product] {
        return [PeaProduct(), EggProduct(), MilkProduct(), BeanProduct()]
    }
}
