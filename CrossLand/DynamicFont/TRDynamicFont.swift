//
//  TRDynamicFont.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/19.
//

import UIKit


extension UIFont {
    
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
    func light() -> UIFont {
        let title1PointSize = self.pointSize
        return UIFont.systemFont(ofSize: title1PointSize, weight: .light)
    }
    
    
}

extension UILabel {
    
    @IBInspectable var drawColorTint: Bool {
        set {
            if #available(macCatalyst 15.0,iOS 15.0, *) {
                self.textColor = .tintColor
            }
        }
        get {
            return self.textColor == tintColor
        }
    }
    
    @IBInspectable var dynamicBoldFontStyle: Bool {
        
        set {
            self.font = self.font.bold()
        }
        
        get {
            return self.dynamicBoldFontStyle
        }
    }
    
    @IBInspectable var dynamicLightFontStyle: Bool {
        set {
            self.font = self.font.light()
        }
        
        get {
            return self.dynamicLightFontStyle
        }
    }
}


