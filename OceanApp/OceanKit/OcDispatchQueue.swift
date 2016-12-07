
//
//  DispatchQueue.swift
//  OceanApp
//
//  Created by rookie on 2016/12/6.
//  Copyright © 2016年 rookie. All rights reserved.
//

import Foundation


public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
        
    }
    
}
