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
        set { toolNameLabel.text = newValue }
        get { return toolNameLabel.text }
    }
    
    @IBInspectable var actualTemp: String? {
        set { actualTempLabel.text = newValue }
        get { return actualTempLabel.text }
    }
    
    @IBInspectable var targetTemp: String? {
        set { targetTempLabel.text = newValue }
        get { return targetTempLabel.text }
    }
    
    @IBInspectable private var tempUnit: String? {
        set {
            actualTempUnitLabel.text = newValue
            targetTempUnitLabel.text = newValue
        }
        get { return actualTempUnitLabel.text }
    }
    
    var state: ToolTemperatureState? {
        didSet {
            toolName    = self.state?.toolName

            actualTemp  = String(format:"%.1f",  self.state?.actualTemp ?? 0)
            targetTemp  = String(format:"%.1f",  self.state?.targetTemp ?? 0)
            
            tempUnit    = "C" // Currently Octoprint Only Returns Celsius
            // This is NOT reflected in the return data, and this exists
            // solely for future proofing
        }
    }
}
