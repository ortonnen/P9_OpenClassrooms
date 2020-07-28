//
//  ExchangeRateViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

//Tips: tu peux changer le type de clavier (dans notre cas un keyboard de type .numberPad)
// textField.KeyboardType = .numberPad

class ExchangeRateViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: Proprieties
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var convertResultLabel: UILabel!
    @IBOutlet weak var moneyEnterText: UITextField!
    @IBOutlet weak var endingCurrencyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var rate = Double()
    private var amount = Double()
    private var amountConvert = String()
    private var currencyExchange = CurrencyExchange()
    
    var currency: CurrencyRate = CurrencyRate.empty() {
        didSet {
            //4
            endingCurrencyPickerView.reloadAllComponents()
        }
    }
    var currentRate: Double?


    //MARK: Methode
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        endingCurrencyPickerView.dataSource = self
        endingCurrencyPickerView.delegate = self
        
//        endingCurrencyPickerView.backgroundColor = .gray
        
        //1
        searchRate()
    }

    @IBAction func tappedConvertButton() {
        guard moneyEnterText.text != "" && moneyEnterText.text != nil else { return missingArgumentAlerte() }
        //searchRate()
        
        if let text = moneyEnterText.text, let number = Double(text) {
            if let rate = currentRate {
                let result = currencyExchange.convertMoney(from: number, to: rate)
                convertResultLabel.text = String(result)
            }
        }
    }

    private func convert(with rate: Double) {
        //prendre en charge avec la virgule (création alerte)
        amount = Double(moneyEnterText.text!)!
        amountConvert = String(currencyExchange.convertMoney(from: amount, to: rate))
        convertResultLabel.text = amountConvert
    }

    //2
    private func searchRate(){
        toggleActivityIndicator(shown: true)
        CurrencyRateService.shared.getCurrencyRate { (success, currency) in
            self .toggleActivityIndicator(shown: false)
            guard success, let currency = currency else { return self.connectionAlerte() }
            //3
            self.currency = currency
            //self.rate = currency.rates["USD"]!
            //self.convert(with: self.rate)
        }
    }

    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        convertButton.isHidden = shown
    }
}

//MARK: PickerView
extension ExchangeRateViewController {

    //5
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.rates.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        for (index, element) in currency.rates.enumerated() {
            if index == row {
                //6
                currentRate = element.value
                return element.key
            }
        }
        return nil
    }
}

//MARK: Keyboard
extension ExchangeRateViewController {

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

