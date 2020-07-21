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
    @IBOutlet weak var endingCurrencyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var rate = Double()
    private var amount = Double()
    private var amountConvert = String()
    private var currencyExchange = CurrencyExchange()
    private var currencyRateService = CurrencyRateService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        endingCurrencyPickerView.delegate = self
    }

    @IBAction func tappedConvertButton() {
        guard moneyEnterText.text != "" && moneyEnterText.text != nil else { return missingArgumentAlerte() }
        searchRate()
    }

    private func convert(with rate: Double) {
        amount = Double(moneyEnterText.text!)!
        amountConvert = String(currencyExchange.convertMoney(from: amount, to: rate))
        convertResultLabel.text = amountConvert
    }

    private func searchRate(){
        toggleActivityIndicator(shown: true)
        CurrencyRateService.shared.getCurrencyRate { (success, currency) in
            self .toggleActivityIndicator(shown: false)
            guard success, let currency = currency, currency.rates["USD"] != nil else { return self.connectionAlerte() }
            self.rate = currency.rates["USD"]!
            self.convert(with: self.rate)
        }
    }

    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        convertButton.isHidden = shown
    }
}
//MARK: Keyboard
extension ExchangeRateViewController {

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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK: Alerte
extension ExchangeRateViewController {

    private func missingArgumentAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "Entrez une expression correcte", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }
    private func connectionAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "un problème est survenue merci de rééssayer plus tard", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }
}

