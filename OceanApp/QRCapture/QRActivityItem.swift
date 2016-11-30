//
//  QRActivityItem.swift
//  OceanApp
//
//  Created by rookie on 2016/11/30.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class QRActivityItem: NSObject, UIActivityItemSource {
    
    var image : UIImage?
    var url   : URL?
    
    convenience init(_ _url: URL?, _ _image: UIImage?) {
        self.init()
        image = _image
        url   = _url
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return image ?? UIImage()
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any? {
        return url
    }
    
}
