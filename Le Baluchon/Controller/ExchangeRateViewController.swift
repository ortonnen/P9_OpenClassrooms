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
    @IBOutlet weak var monayEnterText: UITextField!//change name of outlet
    @IBOutlet weak var startingCurrencyPickerView: UIPickerView!
    @IBOutlet weak var endingCurrencyPickerView: UIPickerView!

    private var amount = Double()
    private var amountConvert = String()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedConvertButton() {

        amount = Double(monayEnterText.text!)!
        amountConvert = String(CurrencyRateService.shared.convertMoney(with: amount))
        convertResultLabel.text = amountConvert
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        monayEnterText.resignFirstResponder()
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

}

