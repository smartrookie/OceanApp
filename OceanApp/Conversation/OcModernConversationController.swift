//
//  OcModernConversationController.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/20.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class OcModernConversationController: UIViewController {

    
    var inputTextPanel : OcConversationInputPanel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white    
        
        
        inputTextPanel = OcConversationInputPanel(frame: CGRect(x: 0,
                                                                y: view.frame.height - 45,
                                                                width: view.frame.width,
                                                                height: 45))
//       inputTextPanel?.delegate = self
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
