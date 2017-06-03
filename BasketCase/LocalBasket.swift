//
//  LocalBasket.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import Foundation

struct LocalBasketEntry: BasketEntry {
    let product: Product
    let quantity: Int
    
    func byAdding(_ quantity: Int) -> LocalBasketEntry {
        guard quantity > 0 else { return self }
        
        return LocalBasketEntry(product: self.product, quantity: self.quantity + quantity)
    }
    
    func byRemoving(_ quantity: Int) -> LocalBasketEntry {
        if quantity > self.quantity {
            // Removing too much == removing all
            return LocalBasketEntry(product: self.product, quantity: 0)
        }
        else {
            return LocalBasketEntry(product: self.product, quantity: self.quantity - quantity)
        }
    }
}

class LocalBasket {
    var content: [LocalBasketEntry] = []
    
    func contains(_ product: Product) -> Bool {
        return content.filter { $0.product.productId == product.productId }.count > 0
    }
    
    func entry(of product: Product) -> LocalBasketEntry? {
        return content.filter { $0.product.productId == product.productId }.first
    }
    
    func entryIndex(of product: Product) -> Int? {
        return content.index(where: { $0.product.productId == product.productId })
    }
}

extension LocalBasket: Basket {


    func add(_ product: Product, quantity: Int) {
        var newEntry: LocalBasketEntry
        
        if contains(product) {
            // update the entry
            if let index = entryIndex(of: product) {
                let existingEntry = content[index]
                newEntry = existingEntry.byAdding(quantity)
                content[index] = newEntry
            }
            else {
                // TODO: handle DB inconsistency
            }
        }
        else {
            // create the new entry and save it
            newEntry = LocalBasketEntry(product: product, quantity: quantity)
            content.append(newEntry)
        }
    }
    
    func update(_ product: Product, delta: Int) {
        guard contains(product) else { return }        
        guard delta != 0 else { return }
        
        if delta < 0 {
            remove(product, quantity: delta * -1)
        }
        else {
            add(product, quantity: delta)
        }
        
    }
    
    func removeAll() {
        content.removeAll()
    }
    
    func removeAll(_ product: Product) {
        guard contains(product) else { return }
        guard let index = entryIndex(of: product) else { return }
        
        content.remove(at: index)
    }
    
    func remove(_ product: Product, quantity: Int) {
        guard contains(product) else { return }
        guard let index = entryIndex(of: product) else { return }
        
        let newEntry = content[index].byRemoving(quantity)
                
        if newEntry.quantity > 0 {
            content[index] = newEntry
        }
        else {
            content.remove(at: index)
        }
    }
    
    func totalPrice() -> Float {
        return content.reduce(0) {
            return $0 + $1.product.price * Float($1.quantity)
        }
    }
    
    func numberOfItems() -> Int {
        return content.count
    }
    
    func quantity(of product: Product) -> Int {
        guard contains(product) else { return 0 }
        guard let entry = entry(of: product) else { return 0 }
        
        return entry.quantity
    }
    
    func entry(at index: Int) -> BasketEntry? {
        guard index >= 0, index < content.count else { return nil }
        
        return content[index]
    }
    
}
