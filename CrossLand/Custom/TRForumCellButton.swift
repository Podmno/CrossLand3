//
//  TRForumCellButton.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/22.
//

import Foundation
import UIKit

public class TRForumCellButton: ZFRippleButton {
    
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
        self.active(false)
    }
    
    func active(_ status: Bool) {
        
        UIView.animate(withDuration: 0.2) {
            if (status) {
                if #available(macCatalyst 15.0,iOS 15.0, *) {
                    self.backgroundColor = .tintColor
                } else {
                    self.backgroundColor = .accent
                }
                
                self.setTitleColor(.white, for: .normal)
                self.imageView?.tintColor = .white
                self.rippleBackgroundColor = .clear
            } else {
                self.backgroundColor = .secondarySystemBackground
                if #available(macCatalyst 15.0,iOS 15.0, *) {
                    self.setTitleColor(.tintColor, for: .normal)
                    self.imageView?.tintColor = .tintColor
                    self.rippleBackgroundColor = .clear
                } else {
                    self.setTitleColor(.accent, for: .normal)
                    self.imageView?.tintColor = .accent
                    self.rippleBackgroundColor = .clear
                }
            }
        }
        
        
    }
    
    
}
