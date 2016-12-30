//
//  LogoutTableViewCell.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/29.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {
    
    var action : Selector?
    let titleLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        titleLabel.text = "退出登录"
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.contentMode = .center
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.oc_accentColor()
        titleLabel.center = contentView.center
        titleLabel.autoresizingMask = [.flexibleTopMargin,.flexibleLeftMargin,.flexibleBottomMargin,.flexibleRightMargin]
        contentView.addSubview(titleLabel)
        
        
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
