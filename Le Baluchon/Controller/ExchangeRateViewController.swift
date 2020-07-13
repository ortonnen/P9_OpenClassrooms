//
//  ExchangeRateViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    var exchangeRate = ExchangeRate()
    var amount = Float()
    var amountConvert = String()

    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var convertResultLabel: UILabel!
    @IBOutlet weak var monayEnterText: UITextField!//change name of outlet


    override func viewDidLoad() {
          super.viewDidLoad()

          // Do any additional setup after loading the view.
      }

    @IBAction func tappedConvertButton() {

        amountConvert = String(exchangeRate.convertMoney(with: amount))
        convertResultLabel.text = amountConvert
    }

    //change action name
    @IBAction func writeMoneyText(_ sender: Any) {
        amount = sender as! Float
    }

}

