//
//  AddProductViewController.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import UIKit

typealias AddProductHandler = (Product) -> Void

class AddProductViewController: UIViewController {
    var handler: AddProductHandler?
    
    @IBOutlet private weak var inventoryTableView: UITableView!
    fileprivate let inventory = LocalInventory()
    
    let cellId = "inventoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add product"
    }

}

// MARK: - UITableViewDataSource extension
extension AddProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventory.availableProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? InventoryCell else { fatalError("Cannot dequeue cell") }
        
        let product = inventory.availableProducts()[indexPath.row]
        cell.configure(with: product)
        
        return cell
    }
}

// MARK: - UITableViewDelegate extension
extension AddProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handler?(inventory.availableProducts()[indexPath.row])        
    }
}

