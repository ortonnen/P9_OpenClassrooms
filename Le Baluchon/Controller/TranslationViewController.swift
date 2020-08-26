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

    var detectedLanguage = ""
    var desiredLanguage = ""
    
    @IBOutlet weak var textToTranslateView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var changeLanguageSegmentedButton: UISegmentedControl!

    //MARK: Methodes

    override func viewDidLoad() {
        super.viewDidLoad()
        desiredLanguage = "fr"
        // Do any additional setup after loading the view.
    }

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
        detectLang()
        detectLanguageAlerte(detectedLanguage)
    }


    private func detectLang() {
        let acticityIndicatorAlert = presentActivityAlert()
        TranslationService.shared.getDetectLanguage(for: textToTranslateView.text!) { (success, detectLanguage, translationError, translationStatusCodeError) in

            self.present(acticityIndicatorAlert, animated: true, completion: nil)

            guard success else {
                acticityIndicatorAlert.dismiss(animated: true, completion: nil)

                if let translationStatusCodeError = translationStatusCodeError {
                    let errorText = translationStatusCodeError.message
                    return self.statusCodeAlerte(with: errorText)
                } else {
                    acticityIndicatorAlert.dismiss(animated: true, completion: nil)
                    return self.connectionAlerte()
                }
            }
            guard let detectLanguage = detectLanguage else {
                acticityIndicatorAlert.dismiss(animated: true, completion: nil)
                return self.languageDetectionErrorAlerte()

            }
            acticityIndicatorAlert.dismiss(animated: true, completion: nil)
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

    ///Alert if the text field is empty
    private func missingArgumentAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "Saisissez une expression à traduire.", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }

    ///Alert if the error code can be recovered
    private func statusCodeAlerte(with text: String) {
        let alerte = UIAlertController(title: "Erreur", message: "\(text)", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }

    ///Alert if there is a connection problem
    private func connectionAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "un problème est survenue merci de rééssayer plus tard", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }

    /// Alert if we try to translate in the same language
    private func sameLanguageAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "Vous ne pouvez traduire dans la même langue, essayez de selectionner une autre langue.", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }

    /// Alert to prevent which language has been detected
    private func detectLanguageAlerte(_ language: String) {
        let alerte = UIAlertController(title: "Detection de la Langue", message: "La langue suivante a été détectée: \n \(language)", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }

    /// Alert if the language detection failed
    private func languageDetectionErrorAlerte () {
        let alerte = UIAlertController(title: "Detection de la Langue", message: "Oups! Il semble que quelque chose s'est mal passé.", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }

    /// Activity Indicator Alert to wait for language detection
    private func presentActivityAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Détection de la langue", message: "Merci de patienter...\n\n\n", preferredStyle: .alert)

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        alert.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -5.0).isActive = true
        return alert
    }
    
}

//MARK: Keyboard
extension TranslationViewController {

    @IBAction func dismissKeyboard(_ sender: Any) {
        textToTranslateView.resignFirstResponder()
    }
}
