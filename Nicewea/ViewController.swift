//
//  ViewController.swift
//  Nicewea
//
//  Created by Michael on 28.11.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var forecastEffectView: UIVisualEffectView!
    
    @IBOutlet weak var bottomForecastViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibility: UILabel!
    
    
    var forecastParser = ForecastParser()
    
    
    
    var tempValue : String = "" {
        didSet {
            temperatureLabel.text = self.tempValue + "°"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temperatureLabel.text = ""
        conditionLabel.text = ""
        sunriseLabel.text = ""
        sunset.text = ""
        humidity.text = ""
        visibility.text = ""
        temperatureLabel.textColor = UIColor.whiteColor()
        
        activityIndicator.startAnimating()
        forecastParser.getForecast(){
            self.activityIndicator.stopAnimating()
            print(self.forecastParser.temperature)
            self.temperatureLabel.text = self.forecastParser.temperature + "°"
            self.conditionLabel.text = "Yo, feels like " + self.forecastParser.conditionDescription
            self.sunriseLabel.text = "SUNRISE: " + self.forecastParser.sunrise
            self.sunset.text = "SUNSET: " + self.forecastParser.sunset
            self.humidity.text = "HUMIDITY: " + self.forecastParser.humidity
            self.visibility.text = "VISIBILITY: " + self.forecastParser.visibility

        }
        
    }
    

    
    @IBAction func draggedForecastView(sender: UIPanGestureRecognizer) {
        print(sender.locationInView(self.view).y)
        
        UIView.animateWithDuration(0.4, animations: {
            if sender.velocityInView(self.view).y > 0 {
                self.forecastEffectView.frame.size.height = self.view.bounds.height
            } else if sender.velocityInView(self.view).y < 0 {
                self.forecastEffectView.frame.size.height = 250
            }
        })
    }
    

}

