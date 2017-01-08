//
//  PatientListCell.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/4.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

class PatientListCell: OcTableViewCell {
    
    let nameLable = UILabel(frame: CGRect.zero)
    let sexLabel = UILabel(frame: CGRect.zero)
    let lastUpdateTimeLable = UILabel(frame: CGRect.zero)
    
    let leftHand = UILabel()
    let leftHandText = UILabel()
    
    let rightHand = UILabel()
    let rightHandText = UILabel()
    
    let leftFoot = UILabel()
    let leftFootText = UILabel()
    
    let rightFoot = UILabel()
    let rightFootText = UILabel()
    
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
        
        nameLable.font = UIFont.systemFont(ofSize: 15)
        
        contentView.addSubview(nameLable)
        
        contentView.addSubview(sexLabel)
        sexLabel.font = UIFont.systemFont(ofSize: 12)
        
        lastUpdateTimeLable.font = UIFont.systemFont(ofSize: 13)
        lastUpdateTimeLable.textAlignment = .right
        lastUpdateTimeLable.contentMode = .center
        addSubview(lastUpdateTimeLable)
        
        
        leftHand.text = "左手"
        leftHand.font = UIFont.systemFont(ofSize: 12)
        leftHand.sizeToFit()
        
        contentView.addSubview(leftHand)
        
        leftHandText.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(leftHandText)
        
        rightHand.text = "右手"
        rightHand.font = leftHand.font
        rightHand.sizeToFit()
        contentView.addSubview(rightHand)
        
        rightHandText.font = leftHandText.font
        contentView.addSubview(rightHandText)
        
        leftFoot.text = "左脚"
        leftFoot.font = leftHand.font
        leftFoot.sizeToFit()
        contentView.addSubview(leftFoot)
        
        leftFootText.font = leftHandText.font
        contentView.addSubview(leftFootText)
        
        rightFoot.text = "右脚"
        rightFoot.font = leftHand.font
        rightFoot.sizeToFit()
        contentView.addSubview(rightFoot)
        
        rightFootText.font = leftFootText.font
        contentView.addSubview(rightFootText)
        
        height = 76
    }
    
    func configureCell(patient:OcPatient) {
        
        
        //setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var size = nameLable.frame.size
        nameLable.frame = CGRect(x: imageView!.frame.maxX + 12, y: imageView!.frame.minY, width: size.width, height: size.height)
        
        let sexIconSize = sexLabel.frame.size
        sexLabel.frame = CGRect(x: nameLable.frame.minX, y: nameLable.frame.maxY + 8, width: sexIconSize.width, height: sexIconSize.height)
        
        let timeSize = lastUpdateTimeLable.frame.size
        lastUpdateTimeLable.frame = CGRect(x: bounds.width - timeSize.width - 8, y: nameLable.frame.minY, width: timeSize.width, height: timeSize.height)
        
        
        size = leftHand.frame.size
        leftHand.frame = leftHand.bounds.offsetBy(dx: sexLabel.frame.minX, dy: sexLabel.frame.maxY + 8)
        
        leftHandText.frame = CGRect(x: leftHand.frame.maxX + 4, y: leftHand.frame.minY, width: size.width, height: size.height)
        
        //
        rightHand.frame = leftHand.frame.offsetBy(dx: 60, dy: 0)
        
        size = rightHandText.frame.size
        rightHandText.frame = CGRect(x: rightHand.frame.maxX + 4, y: rightHand.frame.minY, width: size.width, height: size.height)
        
        //
        leftFoot.frame = rightHand.frame.offsetBy(dx: 60, dy: 0)
        
        size = leftFootText.frame.size
        leftFootText.frame = CGRect(x: leftFoot.frame.maxX + 4, y: leftFoot.frame.minY, width: size.width, height: size.height)
        
        //
        rightFoot.frame = leftFoot.frame.offsetBy(dx: 60, dy: 0)
        
        size = rightFootText.frame.size
        rightFootText.frame = CGRect(x: rightFoot.frame.maxX + 4, y: rightFoot.frame.minY, width: size.width, height: size.height)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PatientListCell : SWConfigurableCell {
    func configureForObject(object: SWPatient) {
        
        nameLable.text = object.name
        nameLable.sizeToFit()
        
        sexLabel.text = object.sex == 0 ? "男" : "女"
        sexLabel.sizeToFit()
        
        let dateFormatter : DateFormatter = {
            $0.dateFormat = "YYYY-MM-DD HH:mm"
            return $0
        }(DateFormatter())
        
        lastUpdateTimeLable.text = dateFormatter.string(from: object.createTime! as Date)
        
        let flags : [Bool] = object.fingers as! [Bool]
        if flags.count == 20 {
            
            var i = 0
            var count = 0
            for flag in flags {
                i += 1
                if flag {
                    count += 1
                }
                if i == 5 {
                    leftHandText.text = "\(count)"
                    count = 0
                } else if i == 10 {
                    rightHandText.text = "\(count)"
                    count = 0
                } else if i == 15 {
                    leftFootText.text = "\(count)"
                    count = 0
                } else if i == 20 {
                    rightFootText.text = "\(count)"
                    count = 0
                }
            }
            
        }
        
        leftHandText.sizeToFit()
        
        leftFootText.sizeToFit()
        
        rightHandText.sizeToFit()
        
        rightFootText.sizeToFit()
    
        lastUpdateTimeLable.sizeToFit()
    }
}
