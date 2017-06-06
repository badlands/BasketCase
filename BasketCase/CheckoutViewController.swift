//
//  CheckoutViewController.swift
//  BasketCase
//
//  Created by Marco Marengo on 04/06/2017.
//  Copyright © 2017 Marco Marengo. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    @IBOutlet weak var currencySegmentedControl: UISegmentedControl!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var totalAmountInUSD: Float = 0
//    private var currency: Currency = .USD
    
    let ratesProvider: RateProvider = JsonRatesProvider()
    //fileprivate let currencies = ["USD","EUR","GBP","AUD","CAD"];
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        var index = 0
        currencySegmentedControl.removeAllSegments()
        
        ratesProvider.supportedCurrencies.forEach {
            self.currencySegmentedControl.insertSegment(withTitle: $0.name, at: index, animated: false)
            index += 1
        }
        currencySegmentedControl.addTarget(self, action: #selector(onChangeCurrencyTapped), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI(currency: .USD, total: totalAmountInUSD)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChangeCurrencyTapped() {
        
        print("change detected: \(currencySegmentedControl.selectedSegmentIndex)")
        
        guard currencySegmentedControl.selectedSegmentIndex < ratesProvider.supportedCurrencies.count else { return }
        
        let desiredCurrency = ratesProvider.supportedCurrencies[currencySegmentedControl.selectedSegmentIndex]
        
        // Get the change rates
        ratesProvider.getQuotes(from: .USD) { (quotes, error) in
            guard error == nil else { // HANDLE ERROR CASE
                print("there was an error: \(error?.localizedDescription ?? "N/A")")
                return
            }
            
            print("should apply rate = \(quotes)")
            self.updateQuote(desiredCurrency: desiredCurrency, quotes: quotes)
        }
    }
    
    func updateQuote(desiredCurrency: Currency, quotes: [Rate]) {
        if desiredCurrency == .USD {
            updateUI(currency: desiredCurrency, total: totalAmountInUSD)
        }
        
        guard let quote = quotes.filter({ $0.to == desiredCurrency }).first else { return }
        
        print("new total is: \(quote.to.name) *\(quote.quote)")
        updateUI(currency: quote.to, total: totalAmountInUSD*quote.quote)
    }
    
    func updateUI(currency: Currency, total: Float) {
        DispatchQueue.main.async {
            //self.totalAmountLabel.text = currency.name + " \(total)"
            self.totalAmountLabel.text = currency.name + " " + String(format: "%.2f", total)
        }
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
