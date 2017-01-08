//
//  PatientMarkCell.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/8.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

class PatientMarkCell: OcTableViewCell {
    
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.text = "备注:"
        titleLabel.sizeToFit()
        contentView.addSubview(titleLabel)
        
        titleLabel.frame = CGRect(x: 15, y: 8, width: titleLabel.frame.size.width, height: titleLabel.frame.size.height)
        
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screenSize = UIScreen.main.bounds.size
        contentLabel.frame = CGRect(x: titleLabel.frame.minX, y: titleLabel.frame.maxY + 8, width: screenSize.width - 30, height: 0)
        contentLabel.sizeToFit()
    }
    
    
    func heightForText(_ text: String, width : CGFloat) -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: 15)
        let attibuteStr = NSMutableAttributedString(string: text)
        attibuteStr.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, text.characters.count))
        
        let rect = attibuteStr.boundingRect(with: CGSize(width: width,
                                                         height: CGFloat.greatestFiniteMagnitude), options: [.usesFontLeading,.usesLineFragmentOrigin], context: nil)
        
        
        height = ceil( rect.size.height )
        return height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension PatientMarkCell : SWConfigurableCell {
    func configureForObject(object: SWPatient) {
        
        contentLabel.text = object.mark
        
        let screenSize = UIScreen.main.bounds.size
        let textHeight = heightForText(contentLabel.text ?? " ", width: screenSize.width - 30)
        
        height = textHeight + titleLabel.frame.height + 24
        layoutIfNeeded()
    }
}
