//
//  Product.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import Foundation

enum ProductUnit {
    case bag
    case dozen
    case bottle
    case can
    
    var name: String {
        switch self {
        case .bag:
            return "bag"
        case .dozen:
            return "dozen"
        case .bottle:
            return "bottle"
        case .can:
            return "can"
        }
    }
}

typealias ProductId = String

protocol Product {
    var productId: ProductId { get }
    var name: String { get }
    var price: Float { get }
    var unit: ProductUnit { get }
    var imageName: String { get }
}
