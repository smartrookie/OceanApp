//
//  OcPhoneUtils.swift
//  OceanApp
//
//  Created by rookie on 2016/12/6.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit
import BLPhoneFormat

class OcPhoneUtils: NSObject {
    
    class func formatPhone(_ phone: String, forceInternational: Bool) -> String {
        return RMPhoneFormat.instance().format(phone, implicitPlus: forceInternational)
    }
    
    func formatPhone(_ phone: String) -> String {
        
        var cleanPhone = [Character]()
        for c in phone.characters {
            if !(c == " " || c == "(" || c == ")" || c == "-") {
                cleanPhone.append(c)
            }
        }
        return String(cleanPhone)
    }
    
    
    func cleanPhone(_ phone: String) -> String {
        var buf = [Character]()
        for c in phone.characters {
            if (c >= "0" && c <= "9") {
                buf.append(c)
            }
        }
        return String(buf)
    }
    
    func cleanInternationalPhone(_ phone: String, forceInternational: Bool) -> String {
        return ""
    }

}
