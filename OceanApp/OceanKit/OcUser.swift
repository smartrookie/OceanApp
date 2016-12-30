//
//  OcUser.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/23.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

enum OcUserSex {
    case unkown
    case male
    case femal
}

class OcUser: NSObject {

    var uid = ""
    
    var phoneNumber = ""
    var firstName = ""
    var lastName  = ""
    var userName  = ""
    var phonebookFirstName = ""
    var phonebookLastName = ""
    var sex : OcUserSex = .unkown
    var photoUrlSmall = ""
    var photoUrlMedium = ""
    var photoUrlBig = ""
    
    func isEqualToUser(_ another: OcUser?) -> Bool {
        guard let _ = another else {
            return false
        }
        return uid == another!.uid
    }
    
}
