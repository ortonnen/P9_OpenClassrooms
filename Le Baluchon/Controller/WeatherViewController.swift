//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 21/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var validateButton: UIButton!

    @IBOutlet weak var sunriseHourLabel: UILabel!
    @IBOutlet weak var sunsetHourLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var humidityLevelLabel: UILabel!

    private var weatherTranslate = WeatherTranslate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedValidateButton() {
        guard cityTextField.text != "" && cityTextField.text != nil else {
            return missingArgumentAlerte()
        }
        
        searchWeather()
    }
    
    private func searchWeather(){
        WeatherService.shared.getweather(for: cityTextField.text!) { (success, weather) in
            guard success else {
                print("error success")
                return self.connectionAlerte()
            }
            
            guard let weather = weather else {
                print("error weather")
                return self.connectionAlerte()
            }

            print("\(self.cityTextField.text!)")
            print ("Température: \(weather.main.temp)°C")
            print("wind Speed: \(self.weatherTranslate.windSpeedConvert(from: weather.wind.speed)) Km/H")
            print("Wind direction \(self.weatherTranslate.convertDegreeToWindDirection(for: weather.wind.deg))")
            print("Humidity \(weather.main.humidity) %")
            print("sunrise: \(self.weatherTranslate.sunHourConvert(for: weather.sys.sunrise))")
            print("sunset: \(self.weatherTranslate.sunHourConvert(for: weather.sys.sunset))")

            self.temperatureLabel.text = "\(weather.main.temp)"
//            self.weatherImageView.image = 
            //            self.windSpeedLabel.text = "\(self.weatherTranslate.windSpeedConvert(mPerS:weather.wind.speed))"
            //            self.sunriseHourLabel.text = "\(weather.sys.sunrise)"
            //            self.sunsetHourLabel.text = "\(weather.sys.sunset)"
            //            self.windDirectionLabel.text = "\(weather.wind.deg)"
            //                        self.humidityLevelLabel.text = "\(weather.main.humidity)"
        }
    }

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


