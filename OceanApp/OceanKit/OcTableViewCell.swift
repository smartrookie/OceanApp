//
//  OcTableViewCell.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/4.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit


protocol SWConfigurableCell : class {
    associatedtype DataSource
    func configureForObject(object: DataSource)
}


class OcTableViewCell: UITableViewCell {
    
    var height : CGFloat = 44
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
