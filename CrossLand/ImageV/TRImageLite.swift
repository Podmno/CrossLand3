//
//  TRImageLite.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/24.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage
//import Hero

public class TRImageLite: UIView {
    
    let image = UIImageView()
    public var imageUrl = ""
    
    public var clickedResponse = {
        print("image clicked... (placeholder)")
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        self.addSubview(image)
        //image.layer.cornerRadius = 8.0
        //image.contentMode = .
        
        
        //image.heroID = "placeHolderImage"
        //blurLayer.heroID = "placeHolderBlur"
        //image.image = UIImage(named: "picDemoPlaceholder")
        image.snp.makeConstraints { snp in
            snp.top.bottom.left.right.equalToSuperview()
        }
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tap)
        
        if (!imageUrl.isEmpty) {
            refreshImage()
        }
    }
    

    
    public func refreshImage() {
        //image.layer.cornerRadius = 8.0
        self.image.alpha = 1.0
        self.image.af.setImage(withURL: URL(string: self.imageUrl)!)
    }
    
    public func removeImage() {
        self.image.alpha = 0.0
    }
    
    @objc func imageViewClick(tap: UIGestureRecognizer) {
        clickedResponse()
    }
    
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
