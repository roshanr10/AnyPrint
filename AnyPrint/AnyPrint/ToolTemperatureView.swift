//
//  ToolTemperatureView
//  AnyPrint
//
//  Created by Roshan Ravi on 7/17/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

@IBDesignable class ToolTemperatureView: CustomUIView {
    @IBOutlet weak var toolNameLabel: UILabel!
    @IBOutlet weak var actualTempLabel: UILabel!
    @IBOutlet weak var targetTempLabel: UILabel!
    @IBOutlet weak var actualTempUnitLabel: UILabel!
    @IBOutlet weak var targetTempUnitLabel: UILabel!
    
    @IBInspectable var toolName: String? {
        set {
            toolNameLabel.text = newValue
        }
        get {
            return toolNameLabel.text
        }
    }
    
    @IBInspectable var actualTemp: String? {
        set {
            actualTempLabel.text = newValue
        }
        get {
            return actualTempLabel.text
        }
    }
    
    @IBInspectable var targetTemp: String? {
        set {
            targetTempLabel.text = newValue
        }
        get {
            return targetTempLabel.text
        }
    }
    
    @IBInspectable var tempUnit: String? {
        set {
            actualTempUnitLabel.text = newValue
            targetTempUnitLabel.text = newValue
        }
        get {
            return actualTempUnitLabel.text
        }
    }
}
