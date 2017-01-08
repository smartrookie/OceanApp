//
//  SWCoreData.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/7.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit
import CoreData
import Foundation


extension NSManagedObjectContext {
    
    public func insertObject<A: NSManagedObject>() -> A where A: SWManagedObjectType  {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }
    
    public func saveOrRallback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    public func performChanges(block: @escaping ()->Void) {
        perform { 
            block()
            let _ = self.saveOrRallback()
        }
    }
    
}


class SWCoreData: NSObject {

    let storeURL = NSURL.documentsURL.appendingPathComponent("OceanApp.moody")
    
    public func createMoodyMainContext() -> NSManagedObjectContext {
        let bundles = [Bundle(for: SWPatient.self)]
        
        guard let model = NSManagedObjectModel.mergedModel(from: bundles) else {
            fatalError("model not found")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = psc
        return context
    }
    

    
}

extension NSURL {
    
    static func temporaryURL() -> NSURL {
        
        return try! FileManager.default.url(for: FileManager.SearchPathDirectory.cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(NSUUID().uuidString) as NSURL
    }
    
    static var documentsURL: NSURL {
        return try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) as NSURL
    }
    
}
