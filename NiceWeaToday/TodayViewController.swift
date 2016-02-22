//
//  TodayViewController.swift
//  NiceWeaToday
//
//  Created by Michael on 02.12.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var tempLabel: UILabel!
    
    let parser = ForecastParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.getForecast({
            self.tempLabel.text = self.parser.temperature+"°\n"+self.parser.conditionDescription
        })
    }
    
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {

        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
}
