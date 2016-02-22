//
//  ForecastParser.swift
//  Nicewea
//
//  Created by Michael on 30.11.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import Foundation

class ForecastParser {
    
    var temperature: String!
    var sunrise: String!
    var sunset: String!
    var humidity: String!
    var pressure: String!
    var rising: String!
    var visibility: String!
    var conditionDescription: String!
    
    func getForecast(completionHandler: () -> Void) {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let url = NSURL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22tambov%22)%20and%20u%3D'c'&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")
        var dict : NSDictionary!
        
        let task = session.dataTaskWithURL(url!, completionHandler: {
            (data, response, error) -> Void in
            do {
                dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! NSDictionary
                self.sunrise = dict["query"]!["results"]!!["channel"]!!["astronomy"]!!["sunrise"] as! String
                self.sunset = dict["query"]!["results"]!!["channel"]!!["astronomy"]!!["sunset"] as! String
                self.humidity = dict["query"]!["results"]!!["channel"]!!["atmosphere"]!!["humidity"] as! String
                self.pressure = dict["query"]!["results"]!!["channel"]!!["atmosphere"]!!["pressure"] as! String
                self.rising = dict["query"]!["results"]!!["channel"]!!["atmosphere"]!!["rising"] as! String
                self.visibility = dict["query"]!["results"]!!["channel"]!!["atmosphere"]!!["visibility"] as! String
                self.conditionDescription = dict["query"]!["results"]!!["channel"]!!["item"]!!["condition"]!!["text"] as! String
                self.temperature = dict["query"]!["results"]!!["channel"]!!["item"]!!["condition"]!!["temp"] as! String
                
            } catch {
                print(error)
            }
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler()
            })
        })
        
        task.resume()
    }
}