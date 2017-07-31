//
//  ToolTemperatureView
//  AnyPrint
//
//  Created by Roshan Ravi on 7/17/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class ToolTemperatureView: CustomUIView {
    @IBOutlet weak var toolNameLabel: UILabel!
    @IBOutlet weak var actualTempLabel: UILabel!
    @IBOutlet weak var targetTempLabel: UILabel!
    @IBOutlet weak var actualTempUnitLabel: UILabel!
    @IBOutlet weak var targetTempUnitLabel: UILabel!
    
    private var tempUnit: String? {
        set {
            actualTempUnitLabel.text = newValue
            targetTempUnitLabel.text = newValue
        }
        get { return actualTempUnitLabel.text }
    }
    
    var state: ToolTemperatureState? {
        didSet {
            toolNameLabel.text    = self.state?.toolName

            actualTempLabel.text  = String(format:"%.1f",  self.state?.actualTemp ?? 0)
            targetTempLabel.text  = String(format:"%.1f",  self.state?.targetTemp ?? 0)
            
            tempUnit    = "C" // Currently Octoprint Only Returns Celsius
            // This is NOT reflected in the return data, and this exists
            // solely for future proofing
        }
    }
}
