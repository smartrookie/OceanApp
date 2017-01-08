//
//  SWManagedObjectType.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/7.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit
import CoreData

public protocol SWManagedObjectType: class {
    
    static var entityName : String {get}
    static var defaultSortDescriptors : [NSSortDescriptor] {get}

}

extension SWManagedObjectType {
    public static var defaultSortDescriptors : [NSSortDescriptor] {
        return []
    }
    
    public static var sortedFetchRequest: NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}

public protocol SWManagedObjectContextSettable : class {
    
    var managerObjectContext : NSManagedObjectContext! {get set}
    
}
