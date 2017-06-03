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
    
    fileprivate let cellId = "basketEntryCell"
    fileprivate let basket = LocalBasket()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        basket.add(MilkProduct(), quantity: 3)
        basket.add(BeanProduct(), quantity: 4)
        basket.add(PeaProduct(), quantity: 5)
        basket.add(EggProduct(), quantity: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshUI() {
        basketTableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? BasketEntryCell else { fatalError("Cannot dequeue cell") }
        
        if let entry = basket.entry(at: indexPath.row) {
            cell.configure(with: entry)
            cell.changeHandler = { [unowned self] delta in
                print("quantity changed by: \(delta)")
                
                self.basket.update(entry.product, delta: delta)
                
                self.refreshUI()
            }
        }
        
        return cell
    }
    
    
}
