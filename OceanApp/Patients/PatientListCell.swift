//
//  PatientListCell.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/4.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

class PatientListCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let avatarImage : UIImage = {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 62, height: 62), false, 0)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(UIColor.white.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 62, height: 62))
            context.setStrokeColor(UIColor.color(hex: "0xd9d9d9").cgColor)
            context.setLineWidth(1)
            context.stroke(CGRect(x: 0.5, y: 0.5, width: 61, height: 61))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image!
        }()
        
        imageView?.image = avatarImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
