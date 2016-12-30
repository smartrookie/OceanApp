//
//  LoginCodeController.swift
//  OceanApp
//
//  Created by rookie on 2016/12/12.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit
import BLPhoneFormat

class LoginCodeController: UIViewController {
    
    let codeField = UITextField()
    
    
    
    var progressWindow : OcProgressWindow?
    
    var inProgress: Bool = false {
        willSet {
            if newValue != inProgress {
                if newValue {
                    progressWindow = OcProgressWindow(frame: UIScreen.main.bounds)
                    progressWindow?.show(animated: true)
                    
                } else {
                    if let _ = progressWindow {
                        progressWindow?.dismiss(animated: true)
                        progressWindow = nil
                    }
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        view.backgroundColor = UIColor.white
        
        let grayBackground = UIView(frame: CGRect(x: 0.0,
                                                  y: 0.0,
                                                  width: UIScreen.main.bounds.width,
                                                  height: 131))
        grayBackground.backgroundColor = UIColor.color(hex: "0xf2f2f2")
        view.addSubview(grayBackground)
        
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.contentMode = .center
        titleLabel.text = RMPhoneFormat.instance().format("18612259290", implicitPlus: false)
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: (UIScreen.main.bounds.width - titleLabel.frame.width)/2 ,
                                  y: 71,
                                  width: titleLabel.frame.width,
                                  height: titleLabel.frame.height)
        view.addSubview(titleLabel)
        
        let separatorHeight : CGFloat = 0.5
        let separatorView = UIView(frame: CGRect(x: 0,
                                                 y: grayBackground.frame.size.height,
                                                 width: grayBackground.frame.size.width,
                                                 height: separatorHeight))
        separatorView.backgroundColor = UIColor.color(hex: "0xc8c7cc")
        view.addSubview(separatorView)
        
        
        let noticeLabel = UILabel()
        noticeLabel.font = UIFont.systemFont(ofSize: 16)
        noticeLabel.textColor = UIColor.black
        noticeLabel.textAlignment = .center
        noticeLabel.contentMode = .center
        noticeLabel.numberOfLines = 0
        makeLabelWithFormatted(textLabel: noticeLabel, text: "We have sent you an SMS with the code")
        noticeLabel.backgroundColor = UIColor.clear
        view.addSubview(noticeLabel)
        
        let noticeSize = noticeLabel.sizeThatFits(CGSize(width: 300, height: UIScreen.main.bounds.height))
        let noticeRect = CGRect(x: 0, y: 0, width: noticeSize.width, height: noticeSize.height)
        noticeLabel.frame = noticeRect.offsetBy(dx: (UIScreen.main.bounds.width - noticeRect.width)/2, dy: separatorView.frame.origin.y + 70).integral
        
        let fieldSeparatorView = UIView()
        fieldSeparatorView.frame = CGRect(x: 22, y: separatorView.frame.origin.y + 60, width: UIScreen.main.bounds.width - 44, height: 0.5)
        fieldSeparatorView.backgroundColor = UIColor.color(hex: "0xc8c7cc")
        view.addSubview(fieldSeparatorView)
        
        
        codeField.font = UIFont.systemFont(ofSize: 24)
        codeField.backgroundColor = UIColor.clear
        codeField.textAlignment = .center
        codeField.contentVerticalAlignment = .center
        codeField.placeholder = "Code"
        codeField.keyboardType = .numberPad
        codeField.delegate = self
        codeField.frame = CGRect(x: 0, y: fieldSeparatorView.frame.origin.y - 56, width: UIScreen.main.bounds.width, height: 56)
        view.addSubview(codeField)
        
        let timeoutLabel = UILabel()
        timeoutLabel.font = UIFont.systemFont(ofSize: 17)
        timeoutLabel.textColor = UIColor.color(hex: "0x999999")
        timeoutLabel.textAlignment = .center
        timeoutLabel.contentMode = .center
        timeoutLabel.numberOfLines = 0
        timeoutLabel.text = "Telegram will call you in 100 s"
        timeoutLabel.backgroundColor = UIColor.clear
        timeoutLabel.sizeToFit()
        view.addSubview(timeoutLabel)
        
        let requestingCallLabel = UILabel()
        requestingCallLabel.font = UIFont.systemFont(ofSize: 17)
        requestingCallLabel.textColor = UIColor.color(hex: "0x999999")
        requestingCallLabel.textAlignment = .center
        requestingCallLabel.contentMode = .center
        requestingCallLabel.numberOfLines = 0
        requestingCallLabel.text = "Requesting a call from Telegram..."
        requestingCallLabel.backgroundColor = UIColor.clear
        requestingCallLabel.alpha = 0
        requestingCallLabel.sizeToFit()
        view.addSubview(requestingCallLabel)
        
        
        let callSentLabel = UILabel()
        callSentLabel.font = UIFont.systemFont(ofSize: 17)
        callSentLabel.textColor = UIColor.color(hex: "0x999999")
        callSentLabel.textAlignment = .center
        callSentLabel.contentMode = .center
        callSentLabel.numberOfLines = 0
        callSentLabel.backgroundColor = UIColor.clear
        callSentLabel.alpha = 0
        view.addSubview(callSentLabel)
        
        timeoutLabel.isHidden = true
        requestingCallLabel.isHidden = true
        callSentLabel.isHidden = true
        
        
        
        
        
        
    }
    
    func makeLabelWithFormatted(textLabel: UILabel, text: String) {
        
        var boldRanges = [NSRange]()
        let cleanText = NSMutableString.init(string: text)
        while true {
            let startRange = cleanText.range(of: "**")
            if startRange.location == NSNotFound {
                break
            }
            cleanText.deleteCharacters(in: startRange)
            let endRange = cleanText.range(of: "**")
            if endRange.location == NSNotFound {
                break
            }
            
            cleanText.deleteCharacters(in: endRange)
            boldRanges.append(NSMakeRange(startRange.location, endRange.location - startRange.location))
        }
        
        if textLabel.responds(to: #selector(setter: UILabel.attributedText)) {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 1
            style.lineBreakMode = .byWordWrapping
            style.alignment = .center
            
            let attributeString = NSMutableAttributedString(string: String( cleanText ), attributes: [ NSFontAttributeName : textLabel.font ,
                                                                                                NSForegroundColorAttributeName : textLabel.textColor])
            attributeString.addAttributes([NSParagraphStyleAttributeName:style], range: NSMakeRange(0, attributeString.length))
            let boldAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17)]
            for nRange in boldRanges {
                attributeString.addAttributes(boldAttributes, range:nRange)
            }
            textLabel.attributedText = attributeString
        } else {
            textLabel.text = text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func nextButtonPressed() {
        if inProgress {
            return
        }
        
        inProgress = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.inProgress = false
            self.dismiss(animated: true, completion: nil)
        }
    }

}


extension LoginCodeController : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == codeField {
            let replacementString = string
            
            for c in replacementString.characters{
                if c < Character("0") || c > Character("9") {
                    return false
                }
            }
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: replacementString)
            if newText.characters.count > 5 {
                return false
            }
            textField.text = newText
            
            if newText.characters.count == 5 {
                nextButtonPressed()
            }
            return false
        }
        return true
    }
    
    
    
    
}







