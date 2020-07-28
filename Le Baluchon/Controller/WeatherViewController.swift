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

    override func viewDidLoad() {
        super.viewDidLoad()
        searchWeather()

        // Do any additional setup after loading the view.
    }
    @IBAction func tappedValidateButton() {

        searchWeather()
    }

    private func searchWeather(){
        WeatherService.shared.getweather(for: "Erquy") { (success, weather) in
            guard success else {
            print("error success")
            return}

            guard let weather = weather else {
                print("error weather")
                return
            }
            print ("\(weather.temperature.temp)")
            self.temperatureLabel.text = "\(weather.temperature.temp)"
        }
    }

}
