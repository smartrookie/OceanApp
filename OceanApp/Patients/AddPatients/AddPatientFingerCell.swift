//
//  AddPatientFingerCell.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/5.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

class AddPatientFingerCell: OcTableViewCell {
    
    
    public var fingerFlag : [Bool] {
        var flags = [Bool]()
        for button in fingerButtons {
            flags.append(button.isSelected)
        }
        return flags
    }
    
    let leftHandLabel   = UILabel()
    let rightHandLabel  = UILabel()
    let leftFootLabel   = UILabel()
    let rightFootLabel  = UILabel()
    
    let labelFont = UIFont.systemFont(ofSize: 12)
    let labelTextColor = UIColor.oc_lightGrayColor()
    
    
    let fingerTexts = ["小指","无名指","中指","拾指","拇指",
                       "拇指","拾指","中指","无名指","小指",
                       "小趾","无名趾","中趾","拾趾","拇趾",
                       "拇趾","拾趾","中趾","无名趾","小趾"]
    var fingerButtons : [OcFingerButton] = [OcFingerButton]()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftHandLabel.text = "左手"
        leftHandLabel.textColor = labelTextColor
        leftHandLabel.font = labelFont
        contentView.addSubview(leftHandLabel)
        leftHandLabel.sizeToFit()
        
        rightHandLabel.text = "右手"
        rightHandLabel.textColor = labelTextColor
        rightHandLabel.font = labelFont
        contentView.addSubview(rightHandLabel)
        rightHandLabel.sizeToFit()
        
        leftFootLabel.text = "左脚"
        leftFootLabel.textColor = labelTextColor
        leftFootLabel.font = labelFont
        contentView.addSubview(leftFootLabel)
        leftFootLabel.sizeToFit()
        
        rightFootLabel.text = "右脚"
        rightFootLabel.textColor = labelTextColor
        rightFootLabel.font = labelFont
        contentView.addSubview(rightFootLabel)
        rightFootLabel.sizeToFit()
        
        
        for title in fingerTexts {
            let button = OcFingerButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.sizeToFit()
            button.frame = CGRect(x: 0, y: 0, width: button.frame.width + 16, height: min(40, button.frame.height))
            button.addTarget(self, action: #selector(fingerButtonPressed(_:)), for: .touchUpInside)
            button.isSelected = false
            fingerButtons.append(button)
            contentView.addSubview(button)
        }
        
        selectionStyle = .none
        height = 300
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fingerButtonPressed(_ button: OcFingerButton) {
        button.isSelected = !button.isSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screenWidth = UIScreen.main.bounds.size.width
        let labelSize = leftHandLabel.frame.size
        
        leftHandLabel.frame     = CGRect(x: 15, y: 15, width: labelSize.width, height: labelSize.height)
        rightHandLabel.frame    = CGRect(x: screenWidth - 15 - labelSize.width, y: 85, width: labelSize.width, height: labelSize.height)
        leftFootLabel.frame     = CGRect(x: 15, y: 155, width: labelSize.width, height: labelSize.height)
        rightFootLabel.frame    = CGRect(x: screenWidth - 15 - labelSize.width, y: 225, width: labelSize.width, height: labelSize.height)
        
        var leftSpace : CGFloat = 15
        var topSpace  : CGFloat = leftHandLabel.frame.maxY + 8
        for i in 0 ..< fingerButtons.count {
            let btn = fingerButtons[i]
            let btnSize = btn.frame.size
            
            btn.frame = CGRect(x: leftSpace, y: topSpace, width: btnSize.width, height: btnSize.height)
            
            leftSpace = btn.frame.maxX + 12
            if i == 4 || i == 9 || i == 14 {
                leftSpace = UIScreen.main.bounds.width - btn.frame.maxX
            }
            if (i + 1) % 5 == 0 && i != 0 {
                topSpace = topSpace + 70
            }
            
        }
        
    }

}


class OcFingerButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        layer.borderWidth = 0.5
        layer.cornerRadius = 1
    }
    
    var _isSelected = false
    override var isSelected: Bool {
        set {
            _isSelected = newValue
            if newValue {
                setTitleColor(UIColor.oc_accentColor(), for: .normal)
                layer.borderColor = UIColor.oc_accentColor().cgColor
            } else {
                setTitleColor(UIColor.oc_lightGrayColor(), for: .normal)
                layer.borderColor = UIColor.oc_lightGrayColor().cgColor
            }
        }
        get {
            return _isSelected
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




