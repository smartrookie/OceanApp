//
//  SWDataProvider.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/7.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

protocol SWDataProvider: class {
    associatedtype Object
    func objectAtIndexPath(indexPath: IndexPath) -> Object
    func numberOfItemsInSection(section: Int) -> Int
}

protocol SWDataProviderDelegate: class {
    associatedtype Object
    func dataProviderDidUpdate(updates: [SWDataProviderUpdate<Object>])
}

enum SWDataProviderUpdate<Object> {
    case insert(IndexPath)
    case updates(IndexPath, Object)
    case move(IndexPath, IndexPath)
    case delete(IndexPath)
}
