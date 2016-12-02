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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if self.isKind(of: OcTransparentNavigationBar.self) {
            self.backgroundColor = UIColor.clear
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class OcBlackNavigationBar: OcNavigationBar {
    

}

class OcWhiteNavigationBar: OcNavigationBar {
    
}

class OcTransparentNavigationBar: OcNavigationBar {
    
    
    
    
}
