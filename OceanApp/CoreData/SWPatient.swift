//
//  SWPatient.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/7.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

extension SWPatient : SWManagedObjectType {
    
    public static var entityName: String {
        return "SWPatient"
    }
    
    public static var defaultSortDescriptors : [NSSortDescriptor] {
        return [NSSortDescriptor(key: "createTime", ascending: false)]
    }
    
}
