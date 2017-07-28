//
//  CustomUIView.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/17/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

// Derived from Ref: https://stackoverflow.com/documentation/ios/1362/custom-uiviews-from-xib-files/4443/wiring-elements#t=201707180244458065314
@IBDesignable class CustomUIView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
        
        view.frame = bounds
        
        addSubview(view)
    }
}
