//
//  LoginViewController.swift
//  OceanApp
//
//  Created by rookie on 2016/11/18.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit
import CoreTelephony

class LoginViewController: UIViewController {
    
    
    let noticeLabel = UILabel()
    let termsOfServiceLabel = UILabel()
    let countryCodeField = UITextField()
    let phoneField = UITextField()
    var countryButton : UIButton = UIButton()
    

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
        titleLabel.text = "Phone"
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: (UIScreen.main.bounds.width - titleLabel.frame.width)/2 ,
                                  y: 71,
                                  width: titleLabel.frame.width,
                                  height: titleLabel.frame.height)
        view.addSubview(titleLabel)
        
        
        
        noticeLabel.font = UIFont.systemFont(ofSize: 17)
        noticeLabel.textColor = UIColor.color(hex: "0x999999")
        noticeLabel.backgroundColor = UIColor.clear
        noticeLabel.text = "Please confirm your contry code and enter your phone number."
        noticeLabel.lineBreakMode = .byWordWrapping
        noticeLabel.contentMode = .center
        noticeLabel.numberOfLines = 0
        let noticeSize = noticeLabel.sizeThatFits(CGSize(width: 278.0, height: Double(FLT_MAX) ))
        noticeLabel.frame = CGRect(x: (UIScreen.main.bounds.width - noticeSize.width)/2,
                                   y: 274,
                                   width: noticeSize.width,
                                   height: noticeSize.height)
        view.addSubview(noticeLabel)
        
        
        termsOfServiceLabel.font = UIFont.systemFont(ofSize: 16)
        termsOfServiceLabel.textColor = UIColor.black
        termsOfServiceLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsOfServiceTapGesture(_:))))
        
        
        let rawTermsOfServiceString = NSMutableString(string: "By signing up,\nyou agree to the [Terms of Service].")
        var termsOfServiceString : NSMutableAttributedString?
        
        var extractedRange : NSRange = NSRange()
        let linkRange = rawTermsOfServiceString.range(of: "[")
        if linkRange.location != NSNotFound {
            rawTermsOfServiceString.replaceCharacters(in: linkRange, with: "")
            let linkEndRange = rawTermsOfServiceString.range(of: "]")
            if linkEndRange.location != NSNotFound {
                rawTermsOfServiceString.replaceCharacters(in: linkEndRange, with: "")
                extractedRange = NSMakeRange(linkRange.location, linkEndRange.location - linkRange.location)
            }
        }
        termsOfServiceString = NSMutableAttributedString(string: rawTermsOfServiceString as String, attributes: [NSFontAttributeName : termsOfServiceLabel.font])
        if extractedRange.location != NSNotFound {
            termsOfServiceString?.addAttribute(NSForegroundColorAttributeName, value: UIColor.oc_blueColor(), range: extractedRange)
        }
        termsOfServiceLabel.attributedText = termsOfServiceString
        termsOfServiceLabel.backgroundColor = UIColor.clear
        termsOfServiceLabel.lineBreakMode = .byWordWrapping
        termsOfServiceLabel.textAlignment = .center
        termsOfServiceLabel.contentMode = .center
        termsOfServiceLabel.numberOfLines = 0
        let termsOfServiceSize = termsOfServiceLabel.sizeThatFits(CGSize(width: 278.0, height: Double(FLT_MAX)))
        termsOfServiceLabel.frame = CGRect(x: (UIScreen.main.bounds.width - termsOfServiceSize.width)/2,
                                           y: 330,
                                           width: termsOfServiceSize.width,
                                           height: termsOfServiceSize.height)
        view.addSubview(termsOfServiceLabel)
        
        let rawCountryImage = UIImage(named: "ModernAuthCountryButton")
        let rawCountryImageHighlighted = UIImage(named: "ModernAuthCountryButtonHighlighted")
        
        
        countryButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: rawCountryImage!.size.height))
        countryButton.isExclusiveTouch = true
        countryButton.setBackgroundImage(rawCountryImage?.stretchableImage(withLeftCapWidth: Int(rawCountryImage!.size.width / 2), topCapHeight: 0), for: .normal)
        countryButton.setBackgroundImage(rawCountryImageHighlighted?.stretchableImage(withLeftCapWidth: Int(rawCountryImageHighlighted!.size.width / 2), topCapHeight: 0), for: .highlighted)
        countryButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        countryButton.titleLabel?.textAlignment = .left
        countryButton.setTitleColor(UIColor.black, for: .normal)
        countryButton.contentHorizontalAlignment = .left
        countryButton.addTarget(self, action: #selector(countryButtonPressed(_:)), for: .touchUpInside)
        countryButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 9, right: 14)
        countryButton.frame = CGRect(x: 0,
                                     y: 131,
                                     width: UIScreen.main.bounds.width,
                                     height: rawCountryImage!.size.height)
        view.addSubview(countryButton)
        
        let rawInputImage = UIImage(named: "ModernAuthPhoneBackground")
        let inputBackgrountView = UIImageView(image: rawInputImage?.stretchableImage(withLeftCapWidth: Int(rawInputImage!.size.width / 2), topCapHeight: Int(rawInputImage!.size.height / 2)))
        inputBackgrountView.frame = CGRect(x: 0,
                                           y: countryButton.frame.origin.y + 57,
                                           width: UIScreen.main.bounds.width,
                                           height: rawInputImage!.size.height + 0.5)
        view.addSubview(inputBackgrountView)
        inputBackgrountView.isUserInteractionEnabled = true
        inputBackgrountView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(inputBackgroundTapped(_:))))
        
        
        countryCodeField.font = UIFont.systemFont(ofSize: 20)
        countryCodeField.backgroundColor = UIColor.clear
        countryCodeField.text = "+"
        countryCodeField.textAlignment = .center
        countryCodeField.keyboardType = .numberPad
        countryCodeField.delegate = self
        countryCodeField.contentVerticalAlignment = .center
        countryCodeField.frame = CGRect(x: 14,
                                        y: inputBackgrountView.frame.origin.y + 1.5 ,
                                        width: 68,
                                        height: 56)
        view.addSubview(countryCodeField)
        
        phoneField.font = UIFont.systemFont(ofSize: 20)
        phoneField.backgroundColor = UIColor.clear
        phoneField.placeholder = "Your phone number"
        phoneField.keyboardType = .numberPad
        phoneField.delegate = self
//        phoneField.placeholder
        phoneField.contentVerticalAlignment = .center
        phoneField.frame = CGRect(x: 96,
                                  y: inputBackgrountView.frame.origin.y + 1.5,
                                  width: UIScreen.main.bounds.width - 96 - 10,
                                  height: 56)
        view.addSubview(phoneField)
        
        let separatorHeight : CGFloat = 0.5
        let separatorView = UIView(frame: CGRect(x: 0,
                                                 y: grayBackground.frame.size.height,
                                                 width: grayBackground.frame.size.width,
                                                 height: separatorHeight))
        separatorView.backgroundColor = UIColor.color(hex: "0xc8c7cc")
        view.addSubview(separatorView)
        
        
        
        let rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextButtonPressed(_:)))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed(_:)))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        var countryId : String?
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        if let _ = carrier {
            countryId = carrier?.isoCountryCode
        }
        if let _ = countryId {
            countryId = NSLocale.current.regionCode
        }
        
        var code = 0
        _ = LoginCountriesController.countryName(countryId: countryId!, code: &code)
        if code == 0 {
            code = 1
        }
        countryCodeField.text = String(format: "+%d",code)
        
        updatePhoneTextForCountryFieldText(countryCodeField.text!)
        updateCountry()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func inputBackgroundTapped(_ gesture: UITapGestureRecognizer) {
        
    }
    
    func countryButtonPressed(_ button: UIButton) {
        let loginCountriesController = LoginCountriesController()
        let loginCountriesNavi = UINavigationController(rootViewController: loginCountriesController)
        present(loginCountriesNavi, animated: true, completion: nil)
    }
    
    
    func doneButtonPressed(_ barItem: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    func nextButtonPressed(_ barItem: UIBarButtonItem) {
        
    }
    
    func termsOfServiceTapGesture(_ gesture: UITapGestureRecognizer) {
        
    }
    
    func updatePhoneTextForCountryFieldText(_ countryCodetext: String) {
        
        let rawText = phoneField.text!
        var formattedText = OcPhoneUtils.formatPhone(countryCodetext + rawText, forceInternational: false)
        
        if countryCodetext.characters.count > 1 {
            var i = 0
            var j = 0
            while i < formattedText.characters.count &&
                j < countryCodetext.characters.count {
                let c1 = NSString(string: formattedText).character(at: i)
                let c2 = NSString(string: countryCodetext).character(at: j)
                    if c1 == c2 {
                        j += 1
                    }
                    i += 1
            }
            formattedText = NSString(string: formattedText).substring(from: i)
            
            i = 0
            while i < formattedText.characters.count {
                let c = NSString(string: formattedText).character(at: i)
                if c == NSString(string:"(").character(at: 0)
                    || c == NSString(string:")").character(at: 0)
                    || ( c >= NSString(string:"0").character(at: 0)
                        &&  c >= NSString(string:"9").character(at: 0))
                {
                    break
                }
                i += 1
            }
            formattedText = NSString(string: formattedText).substring(from: i)
            phoneField.text = filterPhoneText(formattedText)
        } else {
            phoneField.text = filterPhoneText(OcPhoneUtils.formatPhone(phoneField.text!, forceInternational: false))
        }
    
    }
    
    func updateCountry() {
        let countryText = countryCodeField.text!
        let countryCode = countryText.substring(from: countryText.index(countryText.startIndex, offsetBy: 1))
        
        let countryName = LoginCountriesController.countryName(code: Int(countryCode) ?? 0)
        countryButton.setTitle(countryName ?? "InvalidCountry Code",
                               for: .normal)
    }
    
    
    func filterPhoneText(_ text: String) -> String {
        for c in text.characters {
            if (c >= "0" && c <= "9") {
                return text
            }
        }
        return ""
    }
    
    
}

extension LoginViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == countryCodeField {
            
            var replacementCharacters = [Character]()
            for c in string.characters {
                if ( c >= "0" && c <= "9") {
                    replacementCharacters.append(c)
                }
            }
            
            if replacementCharacters.count == 0 && (range.length == 0 || range.location == 0 ) {
                return false
            }
            var range = range
            if range.location == 0 {
                range.location += 1
            }
            
            let replacementString = String(replacementCharacters)
            
            var newText = (textField.text! as NSString).replacingCharacters(in: range, with: replacementString)
            
            if newText.characters.count > 5 {
                
                for _ in 0 ... newText.characters.count  {
                    
                    let countryCode = Int ( newText.substring(from: newText.index(newText.startIndex, offsetBy: 1)) )
                    let countryName = LoginCountriesController.countryName(code: countryCode!)
                    
                    if let _ = countryName {
                        phoneField.text = filterPhoneText("\(newText.substring(from: newText.index(newText.endIndex, offsetBy: -1)))" + (phoneField.text ?? ""))
                        newText = newText.substring(to: newText.index(newText.endIndex, offsetBy: -1))
                        phoneField.becomeFirstResponder()
                    }
                }
                if newText.characters.count > 5 {
                    newText = newText.substring(to: newText.index(newText.startIndex, offsetBy: 5))
                }
                
            }
            textField.text = newText
            
            updatePhoneTextForCountryFieldText(newText)
            updateCountry()
            
            return false
            
        } else if textField == phoneField {
            
            var replacementCharacters = [Character]()
            for c in string.characters {
                if ( c >= "0" && c <= "9") {
                    replacementCharacters.append(c)
                }
            }
            
            let replacementString = String(replacementCharacters)
            
            var rawNewString = [Character]()
            for c in replacementString.characters {
                if ( c >= "0" && c <= "9") {
                    rawNewString.append(c)
                }
            }
            
            let string = String(rawNewString)
            let rawText = NSMutableString(capacity: 16)
            let currentText = textField.text
            
            let originalLocation = range.location
            let originalEndLocation = range.location + range.length
            var endLocation = originalEndLocation
            
            
            var range = range
            var i = 0
            for  c in currentText!.characters {
                
                if ( c >= "0" && c <= "9") {
                    rawText.append(String(c))
                } else {
                    if originalLocation > i {
                        if range.location > 0 {
                            range.location -= 1
                        }
                    }
                    if originalEndLocation > i {
                        endLocation -= 1
                    }
                }
                i += 1
            }
            
            var newLength = endLocation - range.location
            if ( newLength == 0 && range.length == 1 && range.location > 0) {
                range.location -= 1
                newLength = 1
            }
            if newLength < 0 {
                return false
            }
            range.length = newLength
            
            //try 
            var caretPosition = range.location + string.characters.count
            rawText.replaceCharacters(in: range, with: string)
            
            let countryCodeText = countryCodeField.text!.characters.count > 1 ? countryCodeField.text : ""
            
            var formattedText = OcPhoneUtils.formatPhone(countryCodeText! + (rawText as String), forceInternational: false)
            if countryCodeText!.characters.count > 1 {
                
                var i = 0
                var j = 0
                while (i < formattedText.characters.count && j < countryCodeText!.characters.count) {
                    let c1 = NSString(string: formattedText).character(at: i)
                    let c2 = NSString(string: countryCodeText!).character(at: j)
                    if c1 == c2 {
                        j += 1
                    }
                    i += 1
                }
                formattedText = NSString(string: formattedText).substring(from: i)
                
                i = 0
                while i < formattedText.characters.count {
                    let c =   NSString(string: formattedText).character(at: i)
                    if ((c == NSString(string:")").character(at: 0) && i != 0)
                        || c == NSString(string:"(").character(at: 0) ||
                        (c >= NSString(string:"0").character(at: 0) && c <= NSString(string:"9").character(at: 0))) {
                        break
                    }
                    i += 1
                }
                formattedText = NSString(string: formattedText).substring(from: i)
            }
            
            let formattedTextLength = formattedText.characters.count
            let rawTextLength = rawText.length
            var newCaretPosition = caretPosition
            var  j = 0
            var k = 0
            while j < formattedTextLength && k < rawTextLength  {
                let c1 = NSString(string: formattedText).character(at: j)
                let c2 = NSString(string: rawText).character(at: k)
                if (c1 != c2) {
                    newCaretPosition += 1
                }
                else {
                    k += 1
                }
                if (k == caretPosition) {
                    break
                }
                j += 1
            }
            textField.text = formattedText;
            
            if (caretPosition >= textField.text!.characters.count) {
                caretPosition = textField.text!.characters.count
            }
            
            let startPosition = textField.position(from: textField.beginningOfDocument, offset: newCaretPosition)
            let endPosition   = textField.position(from: textField.beginningOfDocument, offset: newCaretPosition)
            let selection = textField.textRange(from: startPosition!, to: endPosition!)
            textField.selectedTextRange = selection
        
        }
        
        return false
    }
    
    
    
}








































