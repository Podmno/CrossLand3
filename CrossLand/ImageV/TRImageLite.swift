//
//  TRImageLite.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/24.
//

import UIKit
import SnapKit
import Hero

public class TRImageLite: UIView {
    
    let image = UIImageView()
    
    public var clickedResponse = {
        
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(image)
        image.heroID = "placeHolderImage"
        //blurLayer.heroID = "placeHolderBlur"
        image.image = UIImage(named: "picDemoPlaceholder")
        image.snp.makeConstraints { snp in
            snp.top.bottom.left.right.equalToSuperview()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tap)
    }
    
    @objc func imageViewClick(tap: UIGestureRecognizer) {
        clickedResponse()
    }
    
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
