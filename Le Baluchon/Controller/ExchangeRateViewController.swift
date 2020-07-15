//
//  ExchangeRateViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController, UITextFieldDelegate {
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

        amountConvert = String(CurrencyRateService.shared.convertMoney(with: amount))
        convertResultLabel.text = amountConvert
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        monayEnterText.resignFirstResponder()
    }

}

