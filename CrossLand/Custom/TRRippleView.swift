//
//  TRCommonRippleButton.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/23.
//

import UIKit
import SnapKit



public class TRRippleButton : ZFRippleButton {
    
    @IBInspectable var roundRipple: Bool = false
    @IBInspectable var statusChange: Bool = false
    
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
        
        if (roundRipple) {
            self.rippleOverBounds = true
            self.ripplePercent = 1.5
        }
        
        if (statusChange) {
            self.active(false)
        }
        //self.active(false)
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

//public class TRCommonRippleCell: ZFRippleButton {
//    public override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        self.layer.cornerRadius = 0.0
//        self.trackTouchLocation = true
//        self.shadowRippleRadius = 2.0
//        self.shadowRippleEnable = true
//        self.touchUpAnimationTime = 0.5
//        self.ripplePercent = 1.9
//        self.buttonBold = true
//        
//        self.rippleColor = UIColor(named: "RippleColor") ?? UIColor.clear
//        self.rippleBackgroundColor = .clear
//    }
//}

public class TRRippleCell: UITableViewCell {
    let cell = TRRippleButton()
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    
    public override func layoutSubviews() {
        cell.rippleBackgroundColor = .clear
        cell.rippleColor = UIColor(named: "RippleColor") ?? UIColor.clear
        cell.trackTouchLocation = true
        cell.ripplePercent = 2.0
        cell.isExclusiveTouch = false
        cell.layer.zPosition = 1000
        self.accessoryView?.layer.zPosition = 1200
        self.addSubview(cell)
        
        super.layoutSubviews()
        
        cell.frame = self.bounds
        self.bringSubviewToFront(self.contentView)
        //cell.bringSubviewToFront(cell)

        if (self.accessoryView != nil) {
            self.bringSubviewToFront(self.accessoryView!)
        }
        
    }
    


    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        //cell.touchesBegan(touches, with: event)
        _  = cell.beginTracking(touches.first ?? UITouch(), with: event)
    }
    

    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        cell.endTracking(touches.first ?? UITouch(), with: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        cell.cancelTracking(with: event)
    }
     
    /*
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        cell.touchesMoved(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        cell.touchesCancelled(touches, with: event)
    }
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        super.touchesEstimatedPropertiesUpdated(touches)
        cell.touchesEstimatedPropertiesUpdated(touches)
    }

*/
    
}

