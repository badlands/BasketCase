//
//  BasketViewController.swift
//  BasketCase
//
//  Created by Marco Marengo on 03/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
        
    fileprivate let cellId = "basketEntryCell"
    fileprivate let addEntryCellId = "addEntryCell"
    fileprivate let segueAddProduct = "basket2add"
    
    fileprivate let basket = LocalBasket()
    fileprivate let inventory = LocalInventory()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        basket.add(MilkProduct(), quantity: 1)
        basket.add(BeanProduct(), quantity: 1)
        basket.add(PeaProduct(), quantity: 1)
        basket.add(EggProduct(), quantity: 1)
        
        refreshUI()
    }
    
    func refreshUI() {
        basketTableView.reloadData()
        
        totalLabel.text = "\(basket.totalPrice())"
    }
    
    func onBasketUpdate() {
        refreshUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segueAddProduct == segue.identifier {
            if let vc = segue.destination as? AddProductViewController {
                vc.handler = { [unowned self] product in
                    self.navigationController?.popViewController(animated: true)
                    
                    self.basket.add(product, quantity: 1)
                    self.onBasketUpdate()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource extension
extension BasketViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return basket.numberOfItems()
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? BasketEntryCell else { fatalError("Cannot dequeue cell") }
            
            if let entry = basket.entry(at: indexPath.row) {
                cell.configure(with: entry)
                cell.changeHandler = { [unowned self] delta in
                    print("quantity changed by: \(delta)")
                    
                    self.basket.update(entry.product, delta: delta)
                    
                    self.onBasketUpdate()
                }
            }
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: addEntryCellId) as? AddEntryCell else { fatalError("Cannot dequeue 'addEntry' cell") }
            
            cell.configure(basket.numberOfItems(), numberOfInventoryItems: inventory.availableProducts().count)
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate extension
extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        guard basket.numberOfItems() < inventory.availableProducts().count else { return }
        
        performSegue(withIdentifier: segueAddProduct, sender: nil)
    }
}
