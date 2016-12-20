//
//  OcContactsManager.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/19.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit
import Contacts

let contactsStore : CNContactStore = {
  return CNContactStore()
}()

let ocContactsManager : OcContactsManager = {
    return OcContactsManager()
}()

class OcContactsManager: NSObject {
    
    func requestContactsAuthorization(_ completionHandler: @escaping (Bool)-> Void)  {
        
        if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            completionHandler(true)
            return
        }
        
        contactsStore.requestAccess(for: .contacts) { (enabled, error) in
            
            if enabled {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    
    
    
}
