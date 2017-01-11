//
//  AddPatientPersonCell.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/4.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

class AddPatientPersonCell: OcTableViewCell {
    
    
    public var sex : OcPatientSex {
        let index = sexSegmentControl.selectedSegmentIndex
        switch index {
        case 0:
            return .male
        case 1:
            return .femal
        default:
            return .unkown
        }
    }
    
    let avatarView = UIImageView()
    let nameField   = UITextField()
    let nameFieldLine = CALayer()

    let sexSegmentControl = UISegmentedControl(items: ["男","女"])
    let ageSegmentControl = UISegmentedControl(items: ["0-20","20-40","40-60","60以上"])
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let avataImage = UIImage(named: "")
        avatarView.image = avataImage
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarTapGesture)))
        avatarView.frame = CGRect(x: 15, y: 15, width: 66, height: 66)
        avatarView.backgroundColor = UIColor.oc_micrGrayColor()
        
        contentView.addSubview(avatarView)
        
        nameField.font = UIFont.systemFont(ofSize: 20)
        nameField.placeholder = "输入名称"
        contentView.addSubview(nameField)
        
        nameFieldLine.backgroundColor = UIColor.oc_separatorColor().cgColor
        nameFieldLine.frame = CGRect(x: 0, y: 0, width: 0, height: 0.5)
        contentView.layer.addSublayer(nameFieldLine)
        
        
        
        contentView.addSubview(ageSegmentControl)
        contentView.addSubview(sexSegmentControl)

        selectionStyle = .none
        height = 140
    }
    
    
    func avatarTapGesture() {
        debugPrint("hello avatarTap")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screenSize = UIScreen.main.bounds.size
        
        nameField.frame = CGRect(x: avatarView.frame.maxX + 10, y: avatarView.frame.minY + 12, width: screenSize.width - avatarView.frame.maxX - 20, height: 30)
        
        nameFieldLine.frame = CGRect(x: nameField.frame.minX, y: nameField.frame.maxY + 4, width: nameField.frame.width + 10, height: 0.5)
        
        ageSegmentControl.frame = CGRect(x: screenSize.width - 250, y: nameFieldLine.frame.maxY + 34, width: 240, height: 30)
        
        sexSegmentControl.frame = CGRect(x: 15, y: ageSegmentControl.frame.minY, width: 80, height: 30)
        
    }

}
