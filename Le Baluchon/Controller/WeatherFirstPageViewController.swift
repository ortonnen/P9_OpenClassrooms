//
//  WeatherFirstPageViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 27/08/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

class WeatherFirstPageViewController: UIViewController {

    @IBOutlet weak var cityOneLabel: UILabel!
    @IBOutlet weak var cityOneImageView: UIImageView!
    @IBOutlet weak var cityOneWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var cityOneTemperatureLabel: UILabel!

    @IBOutlet var cityTwoLabel: UILabel!
    @IBOutlet weak var cityTwoImageView: UIImageView!
    @IBOutlet weak var cityTwoWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var cityTwoTemperaturLabel: UILabel!

    var firstSearchWeatherIsFinish = false

    override func viewDidLoad() {
        super.viewDidLoad()

        searchWeather()

        // Do any additional setup after loading the view.
    }

    private func searchWeather(){
        guard cityOneLabel.text != nil && cityOneLabel.text != "" else {
            return connectionAlerte()
        }

        WeatherService.shared.getWeather(for: cityOneLabel.text!) { (success, weather, weatherImage, weatherError, weatherStatusCodeError)   in
                   guard success else {
                       if let weatherStatusCodeError = weatherStatusCodeError {
                           let errorText = weatherStatusCodeError.message
                           return self.statusCodeAlerte(with: errorText)
                       } else {
                           print("error success")
                           return self.connectionAlerte()
                       }}
                   guard let weather = weather else {
                       print("error weather")
                       return self.connectionAlerte()
                   }
                   guard let weatherImage = weatherImage else {
                       print("error weather image")
                       return self.connectionAlerte()
                   }

            self.cityOneTemperatureLabel.text = "\(weather.main.temp) °C"
            self.cityOneWeatherDescriptionLabel.text = "\(weather.weather[0].description)"
            self.cityOneImageView.image = UIImage.init(data: weatherImage.weatherImage)
            self.firstSearchWeatherIsFinish = true
            self.searchCityTowWeather()
        }
    }

    func searchCityTowWeather () {
        guard cityTwoLabel.text != nil && cityTwoLabel.text != "" else {
            return connectionAlerte()
        }
        WeatherService.shared.getWeather(for: cityTwoLabel.text!) { (success, weather, weatherImage, weatherError, weatherStatusCodeError)   in
                   guard success else {
                       if let weatherStatusCodeError = weatherStatusCodeError {
                           let errorText = weatherStatusCodeError.message
                           return self.statusCodeAlerte(with: errorText)
                       } else {
                           print("error success")
                           return self.connectionAlerte()
                       }}
                   guard let weather = weather else {
                       print("error weather")
                       return self.connectionAlerte()
                   }
                   guard let weatherImage = weatherImage else {
                       print("error weather image")
                       return self.connectionAlerte()
                   }

            self.cityTwoTemperaturLabel.text = "\(weather.main.temp) °C"
            self.cityTwoWeatherDescriptionLabel.text = "\(weather.weather[0].description)"
            self.cityTwoImageView.image = UIImage.init(data: weatherImage.weatherImage)
        }

    }

    private func connectionAlerte() {
        let alerte = UIAlertController(title: "Erreur", message: "un problème est survenue merci de rééssayer plus tard", preferredStyle: .alert)
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
}
