//
//  TranslationViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 08/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {

    //MARK: Proprieties

    var alertCollection = GTAlertCollection()
    var detectedLanguage = ""
    var desiredLanguage = ""
    
    @IBOutlet weak var textToTranslateView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var changeLanguageSegmentedButton: UISegmentedControl!

    override func viewDidLoad() {
           super.viewDidLoad()
           alertCollection = GTAlertCollection(withHostViewController: self)
           desiredLanguage = "fr"
           // Do any additional setup after loading the view.
       }

    //MARK: Methodes

    @IBAction func tappedChangeLanguageButton(_ sender: Any) {
        if changeLanguageSegmentedButton.selectedSegmentIndex == 0 {
            desiredLanguage = "fr"
        } else if changeLanguageSegmentedButton.selectedSegmentIndex == 1 {
            desiredLanguage = "en"
        } else if changeLanguageSegmentedButton.selectedSegmentIndex == 2 {
            desiredLanguage = "de"
        } else if changeLanguageSegmentedButton.selectedSegmentIndex == 3 {
            desiredLanguage = "es"
        }
    }

    @IBAction func tappedTranslateButton(_ sender: Any) {
        guard textToTranslateView.text != "" else { return missingArgumentAlerte() }
        guard detectedLanguage != desiredLanguage else { return sameLanguageAlerte() }
        translate()
    }

    @IBAction func detectLanguage(_ sender: Any) {
        guard textToTranslateView.text != "" else {
            return missingArgumentAlerte() }
        alertCollection.presentActivityAlert(withTitle: "Détection de la langue", message: "Merci de patienter...", activityIndicatorColor: UIColor.blue, showLargeIndicator: false) { (presented) in
            if presented {
                self.detectLang()
                self.detectLanguageAlerte(self.detectedLanguage)
            }
        }
        detectLang()
        detectLanguageAlerte(detectedLanguage)
    }


    private func detectLang() {
        TranslationService.shared.getDetectLanguage(for: textToTranslateView.text!) { (success, detectLanguage, translationError, translationStatusCodeError) in
            guard success else {
                self.alertCollection.dismissAlert(completion: nil)
                if let translationStatusCodeError = translationStatusCodeError {
                    let errorText = translationStatusCodeError.message
                    return self.statusCodeAlerte(with: errorText)
                } else {
                    self.alertCollection.dismissAlert(completion: nil)
                    return self.connectionAlerte()
                }
            }
            guard let detectLanguage = detectLanguage else {
                self.alertCollection.dismissAlert(completion: nil)
                return self.alertCollection.presentSingleButtonAlert(withTitle: "Detection de la Langue", message: "Oups! Il semble que quelque chose s'est mal passé.", buttonTitle: "OK", actionHandler: {})

            }
            self.alertCollection.dismissAlert(completion: nil)
            self.detectedLanguage = detectLanguage.data.detections[0][0].language
        }
    }


    private func translate() {
        TranslationService.shared.getTranslate(from: detectedLanguage, to: desiredLanguage ,for: textToTranslateView.text!) { (success, translate, translationError, translationStatusCodeError) in
            guard success else {
                if let translationStatusCodeError = translationStatusCodeError {
                    let errorText = translationStatusCodeError.message
                    return self.statusCodeAlerte(with: errorText)
                } else {
                    return self.connectionAlerte()
                }
            }
            guard let translate = translate else {
                return self.connectionAlerte() }
            self.detectLang()
            self.updateResultTextView(with: translate.data.translations[0].translatedText)
        }
    }

    private func updateResultTextView(with result: String) {
        guard textToTranslateView.text.isEmpty == false else {
            return
        }
        translatedTextView.text = "\(result)"
    }
}

//MARK: Alerte
extension TranslationViewController {

    private func missingArgumentAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "Entrez une expression correcte", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }
    
    private func statusCodeAlerte(with text: String) {
        let alerte = UIAlertController(title: "Erreur", message: "\(text)", preferredStyle: .alert)
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

    private func sameLanguageAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "vous ne pouvez traduire dans la même langues, essayez de selectionner une autre langue", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }

    private func detectLanguageAlerte(_ language: String) {
        let alerte = UIAlertController(title: "Detection de la Langue", message: "La langue suivante a été détectée: \n \(language)", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }
}

//MARK: Keyboard
extension TranslationViewController {

    @IBAction func dismissKeyboard(_ sender: Any) {
        textToTranslateView.resignFirstResponder()
    }
}
