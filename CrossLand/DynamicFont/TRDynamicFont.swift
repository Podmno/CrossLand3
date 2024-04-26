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
    
    func dynamicBoldFontStyle() {
        self.font = self.font.bold()
    }
    
    func drawColorTint() {
        if #available(macCatalyst 15.0,iOS 15.0, *) {
            self.textColor = .tintColor
        }
    }
    
    func dynamicLightFontStyle() {
        self.font = self.font.light()
    }
    

}


