//
//  AccountInfoTableViewCell.swift
//  OceanApp
//
//  Created by 张东风 on 2016/12/29.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class AccountInfoTableViewCell: UITableViewCell {

    let avatarView = UIImageView()
    let nickNameLabel = UILabel()
    let uidLabel      = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let avataImage = UIImage(named: "")
        avatarView.image = avataImage
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarTapGesture)))
        avatarView.frame = CGRect(x: 15, y: 15, width: 66, height: 66)
        avatarView.backgroundColor = UIColor.oc_micrGrayColor()
        
        contentView.addSubview(avatarView)
        
        
        nickNameLabel.frame = CGRect(x: avatarView.frame.maxX + 10,
                                     y: avatarView.frame.minY + 8, width: 10, height: 10)
        nickNameLabel.text = "张学林"
        nickNameLabel.textColor = UIColor.oc_darkGrayColor()
        nickNameLabel.font = UIFont.systemFont(ofSize: 17)
        nickNameLabel.sizeToFit()
        contentView.addSubview(nickNameLabel)
        
        
        uidLabel.frame = CGRect(x: nickNameLabel.frame.origin.x,
                                y: avatarView.frame.maxY - 26, width: 10, height: 10)
        uidLabel.text = "uid : 1000000"
        uidLabel.font = UIFont.systemFont(ofSize: 15)
        uidLabel.textColor = UIColor.oc_lightGrayColor()
        uidLabel.sizeToFit()
        contentView.addSubview(uidLabel)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func avatarTapGesture() {
        debugPrint("hello avatarTap")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
