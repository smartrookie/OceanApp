//
//  SWTableViewDataSource.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/7.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit
import Foundation

protocol SWDataSourceDelegate: class {
    associatedtype Object
    func cellIdentifierForObject(object: Object) -> String
}

class SWTableViewDataSource<Delegate : SWDataSourceDelegate , Data:SWDataProvider, Cell:UITableViewCell> : NSObject, UITableViewDataSource where Delegate.Object == Data.Object , Cell:SWConfigurableCell, Cell.DataSource == Data.Object  {

    let tableView : UITableView
    let dataProvider: Data
    weak var delegate : Delegate!
    
    init(tableView: UITableView, dataProvider: Data, delegate: Delegate) {
        self.tableView = tableView
        self.dataProvider = dataProvider
        self.delegate = delegate
        super.init()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func processUpdates(updates: [SWDataProviderUpdate<Data.Object>]?) {
        guard let updates = updates else {
            return tableView.reloadData()
        }
        tableView.beginUpdates()
        for update in updates {
            switch update {
            case .insert(let indexPath):
                tableView.insertRows(at: [indexPath], with: .fade)
            case .updates(let indexPath, let object):
                guard let cell = tableView.cellForRow(at: indexPath) as? Cell else {
                    break
                }
                cell.configureForObject(object: object)
            case .move(let indexPath, let newIndexPath):
                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .delete(let indexPath):
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        tableView.endUpdates()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = dataProvider.objectAtIndexPath(indexPath: indexPath)
        let identifier = delegate.cellIdentifierForObject(object: object)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Unexpected cell type at \(indexPath)")
        }
        cell.configureForObject(object: object)
        return cell
    }

}
