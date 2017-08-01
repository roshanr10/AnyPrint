//
//  CurrentPrintJobView.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/17/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class CurrentPrintJobView: CustomUIView {
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var filamentUsed: UILabel!
    @IBOutlet weak var approxTime: UILabel!
    @IBOutlet weak var timeSpent: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var currentPrintJob: JobState? {
        didSet {
            self.isHidden = currentPrintJob == nil
            
            fileName.text = currentPrintJob?.job
            filamentUsed.text = "\(currentPrintJob?.filament.length ?? 0)m / \(currentPrintJob?.filament.volume ?? 0)cm³"
            
            approxTime.text = ((currentPrintJob?.timeLeft ?? 0) + (currentPrintJob?.timeSpent ?? 0)).asHMS()
            timeSpent.text = currentPrintJob?.timeSpent.asHMS()
            timeLeft.text = currentPrintJob?.timeLeft.asHMS()
            
            progressBar.progress = Float(currentPrintJob?.percentComplete ?? 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if currentPrintJob == nil { self.isHidden = true }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if currentPrintJob == nil { self.isHidden = true }
    }
}
