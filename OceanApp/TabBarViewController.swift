//
//  TabBarViewController.swift
//  OceanApp
//
//  Created by rookie on 2016/11/29.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let contactsController = ContactsController()
        let contactsNavi = UINavigationController(rootViewController: contactsController)
        contactsNavi.tabBarItem = UITabBarItem(title: "Contacts",
                                               image: UIImage(named: "TabIconContacts"),
                                               selectedImage: UIImage(named: "TabIconContacts_Highlighted"))
        
        let qr_navi = UINavigationController(rootViewController:QRCaptureViewController())
        
        let accountSettingsController = AccountSettingsController()
        let accountNavi = UINavigationController(rootViewController: accountSettingsController)

        accountNavi.tabBarItem = UITabBarItem(title: "Settings",
                                              image: UIImage(named: "TabIconSettings"),
                                              selectedImage: UIImage(named: "TabIconSettings_Highlighted"))
        
        
        
        
        
        viewControllers = [contactsNavi,qr_navi,accountNavi]
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
