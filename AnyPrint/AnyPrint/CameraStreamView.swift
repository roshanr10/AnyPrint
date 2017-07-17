//
//  CameraStreamView.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/17/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class CameraStreamView: UIView {
    // Ref: https://stackoverflow.com/questions/9282365/load-view-from-an-external-xib-file-in-storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let view = Bundle.main.loadNibNamed("CameraStreamView", owner: self, options: nil)!.first as! UIView
        
        self.addSubview(view)
        view.frame = self.bounds
    }

}
