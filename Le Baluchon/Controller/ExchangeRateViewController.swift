//
//  ExchangeRateViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var convertResultLabel: UILabel!
    @IBOutlet weak var moneyEnterText: UITextField!
    @IBOutlet weak var startingCurrencyPickerView: UIPickerView!
    @IBOutlet weak var endingCurrencyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var rate = Double()
    private var amount = Double()
    private var amountConvert = String()
    private var currencyExchange = CurrencyExchange()

    override func viewDidLoad() {
        super.viewDidLoad()

        startingCurrencyPickerView.delegate = self
        endingCurrencyPickerView.delegate = self
    }

    @IBAction func tappedConvertButton() {
        CurrencyRateService.shared.getCurrencyRate { (success, currency) in
            guard success, let currency = currency, currency.rates["USD"] != nil else { return }
            self.rate = currency.rates["USD"]!
        }
        guard moneyEnterText.text != "" && moneyEnterText.text != nil else { return }
        amount = Double(moneyEnterText.text!)!
        amountConvert = String(currencyExchange.convertMoney(from: amount, to: rate))
        convertResultLabel.text = amountConvert
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        moneyEnterText.resignFirstResponder()
    }

}

