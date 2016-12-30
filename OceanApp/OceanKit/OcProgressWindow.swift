//
//  OcProgressWindow.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/29.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class OcProgressWindow: UIWindow {
    
    var dismissed : Bool = false
    
    func show(animated: Bool) {
        (rootViewController as! OcProgressWindowController).show(animated: animated)
    }
    
    func show(delay:Int) {
        let del = DispatchTime.init(uptimeNanoseconds: UInt64(delay))
        DispatchQueue.main.asyncAfter(deadline: del) { 
            self.show(animated: true)
        }
    }
    
    func showAnimated() {
        show(animated: true)
    }
    
    func dismiss(animated: Bool) {
        if !dismissed {
            dismissed = true
            isUserInteractionEnabled = false
            (rootViewController as! OcProgressWindowController).dismiss(animated: animated)
        }
    }
    
    func dismissWithSuccess() {
        if !dismissed {
            dismissed = true
            show(animated: false)
            (rootViewController as! OcProgressWindowController).dismissWithSuccess()
        }
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        windowLevel = UIWindowLevelStatusBar + 10000000.0
        autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        let controller = OcProgressWindowController()
        controller.weakWindow = self
        rootViewController = controller
        
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class OcProgressWindowController: UIViewController {
    
    weak var weakWindow : UIWindow?
    let containerView = UIView()
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.frame = CGRect(x: (view.frame.width - 100) / 2,
                                     y: (view.frame.height - 100) / 2,
                                     width: 100,
                                     height: 100)
        containerView.autoresizingMask = [.flexibleLeftMargin,
                                          .flexibleRightMargin,
                                          .flexibleTopMargin,
                                          .flexibleBottomMargin]
        containerView.alpha = 0.0
        view.addSubview(containerView)
        
        
        let backgroundView = UIImageView(frame: containerView.bounds)
        let rawImage = UIImage(named: "ProgressWindowBackground")!
        backgroundView.image = rawImage.stretchableImage(withLeftCapWidth: Int(rawImage.size.width) / 2, topCapHeight: Int(rawImage.size.height) / 2)
        containerView.addSubview(backgroundView)
        
        activityIndicatorView.frame = activityIndicatorView.frame.offsetBy(dx: (containerView.frame.width - activityIndicatorView.frame.width) / 2,
                                                                           dy: (containerView.frame.height - activityIndicatorView.frame.height) / 2)
        containerView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()

    }
    
    func show(animated: Bool) {
        weakWindow?.isUserInteractionEnabled = true
        weakWindow?.makeKeyAndVisible()
        if animated {
            UIView.animate(withDuration: 0.3, animations: { 
                self.containerView.alpha = 1
            })
        } else {
            containerView.alpha = 1
        }
    }
    
    func dismiss(animated: Bool) {
        weakWindow?.isUserInteractionEnabled = false
        let window = weakWindow
        if animated {
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: { 
                self.containerView.alpha = 0
            }, completion: { (finished) in
                if (finished) {
                    window?.isHidden = true
                    let windows = UIApplication.shared.windows
                    for i in 0 ..< windows.count {
                        if windows[i] != window {
                           windows[i].makeKeyAndVisible()
                        }
                    }
                }
            })
        } else {
            containerView.alpha = 0
            window?.isHidden = true
            let windows = UIApplication.shared.windows
            for i in 0 ..< windows.count {
                if windows[i] != window {
                    windows[i].makeKeyAndVisible()
                }
            }
            
        }
    }
    
    func dismissWithSuccess() {
        let window = weakWindow
        activityIndicatorView.removeFromSuperview()
        window?.isUserInteractionEnabled = false
        
        let checkView = UIImageView(image: UIImage(named: "ProgressWindowCheck"))
        checkView.frame = containerView.frame.offsetBy(dx: (containerView.frame.width - checkView.frame.width) / 2,
                                                       dy: (containerView.frame.height - checkView.frame.height) / 2)
        containerView.addSubview(checkView)
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: UIViewAnimationOptions(rawValue: 0), animations: { 
            self.containerView.alpha = 0
        }) { (finished) in
            if finished {
                window?.isHidden = true
                let windows = UIApplication.shared.windows
                for i in 0 ..< windows.count {
                    if windows[i] != window {
                        windows[i].makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
}
