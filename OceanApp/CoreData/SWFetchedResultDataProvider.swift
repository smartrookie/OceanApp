//
//  SWFetchedResultDataProvider.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/7.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit
import CoreData


class SWFetchedResultDataProvider<Delegate: SWDataProviderDelegate>: NSObject, NSFetchedResultsControllerDelegate , SWDataProvider {

    typealias Object = Delegate.Object
    
    let fetchResultsController : NSFetchedResultsController<NSFetchRequestResult>
    weak var delegate : Delegate!
    var updates : [SWDataProviderUpdate<Object>] = []
    
    init(fetchResultsController: NSFetchedResultsController<NSFetchRequestResult>, delegate: Delegate) {
        self.fetchResultsController = fetchResultsController
        self.delegate = delegate
        super.init()
        self.fetchResultsController.delegate = self
        try! fetchResultsController.performFetch()
    }
    
    func objectAtIndexPath(indexPath: IndexPath) -> Object {
        guard let result = fetchResultsController.object(at: indexPath) as? Object else {
            fatalError("Unexpected object at \(indexPath)")
        }
        return result
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        guard let sec = fetchResultsController.sections?[section] else {
            return 0
        }
        return sec.numberOfObjects
    }
    
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updates = []
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            updates.append(.insert(newIndexPath!))
        case .update:
            let object = objectAtIndexPath(indexPath: indexPath!)
            updates.append(.updates(indexPath!, object))
        case .move:
            updates.append(.move(indexPath!,newIndexPath!))
        case .delete:
            updates.append(.delete(indexPath!))
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate.dataProviderDidUpdate(updates: updates)
    }
    
}
