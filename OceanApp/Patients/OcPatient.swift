//
//  OcPatient.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/4.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

enum OcPatientSex {
    case unkown
    case male
    case femal
}

class OcPatient: NSObject {
    var uid = ""
    
    var phoneNumber = ""
    var firstName = ""
    var lastName  = ""
    var userName  = ""
    var sex : OcPatientSex = .unkown
    var photoUrlSmall = ""
    
    var phonebookFirstName = ""
    var phonebookLastName = ""
    var photoUrlMedium = ""
    var photoUrlBig = ""
    
    
    
    
    
    
    func isEqualToPatient(_ another: OcPatient?) -> Bool {
        guard let _ = another else {
            return false
        }
        return uid == another!.uid
    }
}
