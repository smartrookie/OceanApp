
//
//  PatientDetailCell.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/10.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

class PatientDetailCell: OcTableViewCell {
    
    let fingerTexts = ["小指","无名指","中指","拾指","拇指",
                       "拇指","拾指","中指","无名指","小指",
                       "小趾","无名趾","中趾","拾趾","拇趾",
                       "拇趾","拾趾","中趾","无名趾","小趾"]
    
    
    var avatarImage : UIImageView = UIImageView()
    let nameLabel   = UILabel()
    let sexLabel    = UILabel()
    let ageLabel    = UILabel()
    let dateLabel   = UILabel()
    
    let seperateLine = CALayer()
    
    
    let detailLable = UILabel()
    let markLabel   = UILabel()
    
    let screenSize = UIScreen.main.bounds.size

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(sexLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(detailLable)
        contentView.addSubview(markLabel)
        
        avatarImage.frame = CGRect(x: screenSize.width - 62 - 15, y: 15, width: 62, height: 62)
        avatarImage.layer.borderColor = UIColor.oc_micrGrayColor().cgColor
        avatarImage.layer.borderWidth = 1
        
        nameLabel.font = UIFont.systemFont(ofSize: 21)
        sexLabel.font = UIFont.systemFont(ofSize: 15)
        ageLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        detailLable.font = UIFont.systemFont(ofSize: 16)
        detailLable.numberOfLines = 0
        markLabel.font = UIFont.systemFont(ofSize: 15)
        
        seperateLine.frame = CGRect(x: 15, y: 100, width: screenSize.width - 30, height: 0.5)
        seperateLine.backgroundColor = UIColor.oc_separatorColor().cgColor
        contentView.layer.addSublayer(seperateLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        nameLabel.frame = nameLabel.bounds.offsetBy(dx: 15, dy: 15)
        
        sexLabel.sizeToFit()
        sexLabel.frame = sexLabel.bounds.offsetBy(dx: 15, dy: 46)
        
        ageLabel.sizeToFit()
        ageLabel.frame = ageLabel.bounds.offsetBy(dx: 15 + 20, dy: 50)
        
        dateLabel.sizeToFit()
        dateLabel.frame = dateLabel.bounds.offsetBy(dx: 15 , dy: 65)
        
        detailLable.frame = CGRect(x: 15, y: seperateLine.frame.maxY + 18, width: screenSize.width - 30, height: detailLable.frame.height)
        detailLable.sizeToFit()
        
        
        height = detailLable.frame.maxY + 40
    }
}



extension PatientDetailCell : SWConfigurableCell {
    func configureForObject(object: SWPatient) {
        
        nameLabel.text = object.name
        sexLabel.text = object.sex == 0 ? "男" : "女"
        
        let dateFormatter : DateFormatter = {
            $0.dateFormat = "YYYY/MM/DD"
            return $0
        }(DateFormatter())
        
        dateLabel.text = dateFormatter.string(from: object.createTime! as Date)
        
        var text = ""
        var i = 0
        for flag in object.fingers as! [Bool] {
            if i == 0 {
                text.append("左手：")
            }
            else if i == 5 {
                text.append("右手：")
            }
            else if i == 10 {
                text.append("左脚：")
            }
            else if i == 15 {
                text.append("右脚：")
            }
            
            if flag {
                text.append(fingerTexts[i] + ",")
            }
            
            if [4,9,14].contains(i) {
                text.append("\n\n")
            }
            i += 1
        }
        detailLable.text = text
        
        layoutIfNeeded()
    }
}
