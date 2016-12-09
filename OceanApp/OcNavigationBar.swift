//
//  OcNavigationBar.swift
//  OceanApp
//
//  Created by rookie on 2016/12/2.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class OcNavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var backgoundContainerView = UIView()
    
    class OcNavigationBarLayer: CALayer { }
    
    override class var layerClass: AnyClass {
        get {
            return OcNavigationBarLayer.self
        }
    }
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit(style: self.isKind(of: OcBlackNavigationBar.self) ? .blackTranslucent : .default)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func commonInit(style: UIBarStyle) {
        
        
//        backgoundContainerView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        backgoundContainerView.isUserInteractionEnabled = false
//        super.insertSubview(backgoundContainerView, at: 0)
        
        
        if barStyle == .default {
            tintColor = UIColor.color(hex: "0x007ee5")
        }
        
        backgroundColor = UIColor.clear
    }
    
    
    
    
    
    
}


class OcBlackNavigationBar: OcNavigationBar {
    

}

class OcWhiteNavigationBar: OcNavigationBar {
    
}

class OcTransparentNavigationBar: OcNavigationBar {
    
    
    
    
}
