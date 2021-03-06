//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 21/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var validateButton: UIButton!

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var sunriseHourLabel: UILabel!
    @IBOutlet weak var sunsetHourLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var humidityLevelLabel: UILabel!
    
    private var weatherTranslate = WeatherTranslate()

    //MARK: Methodes

    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
        searchWeather(for: "Erquy")
        // Do any additional setup after loading the view.
    }

    /// button to search weather for city
    @IBAction func tappedValidateButton() {
        guard cityTextField.text != "" && cityTextField.text != nil else {
            return missingArgumentAlerte()
        }
        searchWeather(for: cityTextField.text!)
    }

    /// method to call weather on API and receive result for view
    private func searchWeather(for city: String) {

        WeatherService.shared.getWeather(for: city) { (success, weather, weatherImage, weatherError, weatherStatusCodeError)   in

            guard success else {
                if let weatherStatusCodeError = weatherStatusCodeError {
                    let errorText = weatherStatusCodeError.message
                    return self.statusCodeAlerte(with: errorText)
                } else {
                    print("error success")
                    return self.connectionAlerte()
                }
            }

            guard let weather = weather else {
                print("error weather")
                return self.connectionAlerte()
            }

            guard let weatherImage = weatherImage else {
                print("error weather image")
                return self.connectionAlerte()
            }

            self.weatherImageView.image = UIImage.init(data: weatherImage.weatherImage)
            self.weatherDescriptionLabel.text = "\(weather.weather[0].description)"
            self.temperatureLabel.text = "\(weather.main.temp)"
            self.windSpeedLabel.text = "\(self.weatherTranslate.windSpeedConvert(from:weather.wind.speed))"
            self.sunriseHourLabel.text = "\(self.weatherTranslate.sunHourConvert(for: weather.sys.sunrise))"
            self.sunsetHourLabel.text = "\(self.weatherTranslate.sunHourConvert(for: weather.sys.sunset))"
            self.windDirectionLabel.text = "\(self.weatherTranslate.convertDegreeToWindDirection(for: weather.wind.deg))"
            self.humidityLevelLabel.text = "\(weather.main.humidity)"
        }
    }

    /// activity indicator appear
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        validateButton.isHidden = shown
    }
}

//MARK: Keyboard
extension WeatherViewController {
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        cityTextField.resignFirstResponder()
    }
}

//MARK: Alerte
extension WeatherViewController {

    /// alert if city is empty
    private func missingArgumentAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "Entrez une expression correcte", preferredStyle: .alert)
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

    ///Alert if the error code can be recovered
    private func statusCodeAlerte(with text: String) {
        let alerte = UIAlertController(title: "Erreur", message: "\(text)", preferredStyle: .alert)
        let alerteAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerte.addAction(alerteAction)
        self.present(alerte,animated: true, completion: nil)
    }
}


