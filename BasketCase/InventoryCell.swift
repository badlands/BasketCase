//
//  InventoryCell.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    func configure(with product: Product) {
        productNameLabel.text = product.name
        productDescriptionLabel.text = "USD \(product.price)\nper \(product.unit.name)"
        productImageView.image = UIImage(named: product.imageName)
    }

}
