//
//  BasketEntryCell.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import UIKit

typealias BasketEntryCellChangeHandler = (Int) -> Void

class BasketEntryCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var changeHandler: BasketEntryCellChangeHandler?
    
    func configure(with entry: BasketEntry) {
        productNameLabel.text = entry.product.name
        productDescriptionLabel.text = "Price: \(entry.product.price) per \(entry.product.unit.name)"
        productQuantityLabel.text = "\(entry.quantity)"
        productImageView.image = UIImage(named: entry.product.imageName)
    }
    
    @IBAction private func onAddTapped() {
        changeHandler?(1)
    }
    
    @IBAction private func onRemoveTapped() {
        changeHandler?(-1)
    }
}
