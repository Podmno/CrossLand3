//
//  TRCommonRippleButton.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/23.
//

import UIKit

class TRCommonRippleButton : ZFRippleButton {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 14.0
        self.trackTouchLocation = true
        self.shadowRippleRadius = 2.0
        self.shadowRippleEnable = true
        self.touchUpAnimationTime = 0.5
        self.ripplePercent = 1.9
        self.buttonBold = true
        
        self.rippleColor = UIColor(named: "RippleColor") ?? UIColor.clear
        self.rippleBackgroundColor = .clear
    }
}
