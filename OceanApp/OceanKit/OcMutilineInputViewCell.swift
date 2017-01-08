//
//  OcMutilineInputTableViewCell.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/5.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

class OcMutilineInputCell: OcTableViewCell {
    
    var textString = ""
    
    var editable = true
    var maxLength : Int = 0
    var textChanged : ((String) -> Void)?
    var heightChanged : (()->Void)?
    var selectedBlock : (()->Void)?
    var titleLabel : UILabel = UILabel()
    
    let textView = UITextView()
    let placeholderLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.text = "备注："
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.oc_lightGrayColor()
        titleLabel.sizeToFit()
        addSubview(titleLabel)
        
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.contentInset = UIEdgeInsets.zero
        textView.textContainerInset = textContainerInset
        textView.isScrollEnabled = false
        textView.delegate = self
        addSubview(textView)
        
        
        placeholderLabel.font = textView.font
        placeholderLabel.textColor = UIColor.color(hex: "0xc7c7cd")
        addSubview(placeholderLabel)

        
    }
    
    override var height: CGFloat {
        set {
            
        }
        get {
            return OcMutilineInputCell.heightForText(self.textString, width: UIScreen.main.bounds.width)
        }
    }
    
    
    class func heightForText(_ text:String, width:CGFloat) -> CGFloat {
        let insets = UIEdgeInsets(top: 13, left: 11, bottom: 13, right: 11)
        let font = UIFont.systemFont(ofSize: 16)
        
        let attibuteStr = NSMutableAttributedString(string: text)
        attibuteStr.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, text.characters.count))
        

        let rect = attibuteStr.boundingRect(with: CGSize(width: width - insets.left - insets.right - 10,
                                                                   height: CGFloat.greatestFiniteMagnitude), options: [.usesFontLeading,.usesLineFragmentOrigin], context: nil)
        
        
        let _height = ceil( rect.size.height + insets.top + insets.bottom ) + 20 + 4
        return _height
    }
    
    var _placeholder = ""
    var placeholder : String {
        set{
            _placeholder = newValue
            placeholderLabel.text = _placeholder
            placeholderLabel.sizeToFit()
            setNeedsLayout()
        }
        get {
            return _placeholder
        }
    }
    
    var textContainerInset : UIEdgeInsets {
        set {
            
        }
        get {
            return UIEdgeInsets(top: 13, left: 11, bottom: 13, right: 11)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 15, y: 8, width: titleLabel.frame.width, height: titleLabel.frame.height)
        
        placeholderLabel.frame = placeholderLabel.bounds.offsetBy(dx: textContainerInset.left + 5, dy: textContainerInset.top + 0.5 + titleLabel.frame.height + 4)
        textView.frame = CGRect(x: 0, y:  titleLabel.frame.height + 4, width: bounds.width, height: bounds.height - titleLabel.frame.height + 4)
    }

}

extension OcMutilineInputCell : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let result = NSString(string: textView.text).replacingCharacters(in: range, with: text)
        if maxLength != 0 && result.characters.count > maxLength {
            textView.text = NSString(string: result).substring(to: maxLength)
            textViewDidChange(textView)
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        textString = textView.text
        placeholderLabel.isHidden = !(textString.characters.count == 0)
        _textChanged(textString)
    }
    
    func _textChanged(_ text: String) {
        textChanged?(textString)
        height = OcMutilineInputCell.heightForText(text, width: self.bounds.width)
        heightChanged?()
    }
    
}
