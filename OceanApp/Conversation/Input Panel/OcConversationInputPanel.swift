//
//  OcConversationInputPanel.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/20.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

protocol OcConversationInputPanelDelegate : NSObjectProtocol {
    func inputPanelWillChangeHeight(inputPanel: OcConversationInputPanel, height: CGFloat, duration: Double, animationCurve: Int);
}

class OcConversationInputPanel: UIView {

    weak var delegate: OcConversationInputPanelDelegate?

    func setAvailableSpaceAbove(_ spaceAbove: CGFloat) {
        
    }
    
    func ajustFor(size: CGSize, keyboardHeight: CGFloat, duration: Double, animationCurve: Int) {
        
    }
    
    func changeTo(size: CGSize, keyboardHeight: CGFloat, duration: Double)  {
        
    }
    
}
