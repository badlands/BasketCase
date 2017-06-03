//
//  AddEntryCell.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import UIKit

class AddEntryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    
    func configure(_ numberOfBasketItems: Int, numberOfInventoryItems: Int) {
        if numberOfBasketItems == 0 {
            titleLabel.text = "Your basket looks empty. Would you like to try one of our fresh products?"
            self.accessoryType = .disclosureIndicator
        }
        else if numberOfBasketItems < numberOfInventoryItems {
            titleLabel.text = "There's still room for something good."
            self.accessoryType = .disclosureIndicator
        }
        else {
            titleLabel.text = ""
            self.accessoryType = .none
        }
    }

}
