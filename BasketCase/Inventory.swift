//
//  Inventory.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import Foundation

protocol Inventory {
    func availableProducts() -> [Product]
}
