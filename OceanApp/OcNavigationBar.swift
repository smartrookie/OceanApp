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
        if barStyle == .default {
            tintColor = UIColor.color(hex: "0x007ee5")
        }
        backgroundColor = UIColor.clear
    }
    
    
    func findBackgroundView(_ view: UIView?) -> UIView? {
        guard let _ = view else {
            return nil
        }
        //[NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarBackground"]
        if view!.description.contains("_UINavigationBarBackground") {
            return view
        }
        for subview in view!.subviews {
            let _view = findBackgroundView(subview)
            if let _ = _view {
                return _view
            }
        }
        return nil
    }
    
    override var isHidden: Bool {
        didSet {
            if !isHidden {
                if isKind(of: OcTransparentNavigationBar.self) {
                    let view = findBackgroundView(self)
                    view?.removeFromSuperview()
                }
            }
        }
    }
    
}

class OcBlackNavigationBar: OcNavigationBar {
    
}

class OcWhiteNavigationBar: OcNavigationBar {
    
}

class OcTransparentNavigationBar: OcNavigationBar {

}
