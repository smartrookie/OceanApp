//
//  OcMediaAvatarmenuMixin.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/30.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class OcMediaAvatarmenuMixin: NSObject {
    var didFinishWithImage : ((_ image : UIImage) -> Void)?
    var didFinistWithDelegate : (() -> Void)?
    var didDismiss : (() -> Void)?
    
    
    
    var parentController : UIViewController?
    var hasDeleteButton : Bool?
    var personalPhoto   : Bool?
    
    
    convenience init(parentController : UIViewController, hasDeleteButton: Bool, personalPhoto: Bool = false) {
        self.init()
        self.parentController = parentController
        self.hasDeleteButton = hasDeleteButton
        self.personalPhoto   = personalPhoto
        
    }
    

    
    func present() {
        
    }
    
}
