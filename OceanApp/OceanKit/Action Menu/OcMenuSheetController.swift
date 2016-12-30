//
//  OcMenuSheetController.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/30.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class OcMenuSheetController: UIViewController {
    
    var containerView = UIView()
    var sizeClass : UIUserInterfaceSizeClass?
    var sheetView : OcMenuSheetView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(itemViews : [UIView]) {
        self.init(nibName: nil, bundle: nil)
        
        
        
    }
    
    
    func setItemViews(itemViews : [UIView], animated: Bool = false) {
        let compact = sizeClass == .compact
        weak var weakSelf = self
        let minuRelayout = {
            weakSelf?.repositionMenuWithReferenceSize(referenceSize: UIScreen.main.bounds.size)
        }
        if animated && compact {
            let snapshotView = sheetView?.snapshotView(afterScreenUpdates: false)
            snapshotView?.frame = containerView.convert((sheetView?.frame)!, to: containerView.superview)
//            containerView.superview?.addSubview(snapshotView)
            
            
            
        }
    }
    
    
    func repositionMenuWithReferenceSize(referenceSize: CGSize) {
        if sizeClass == .regular {
            return
        }
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        var statusBarHeight = min(statusBarSize.width, statusBarSize.height)
        statusBarHeight = max(20, statusBarHeight)
//        let menuSize = sheetView.menuSize
//        sheetView.frame =
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
