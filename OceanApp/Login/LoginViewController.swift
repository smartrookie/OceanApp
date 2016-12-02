//
//  LoginViewController.swift
//  OceanApp
//
//  Created by rookie on 2016/11/18.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        view.backgroundColor = UIColor.oc_whiteColor()
        
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
        
        
        let noticeLabel = UILabel()
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
        
        
        let termsOfServiceLabel = UILabel()
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
        
        
        
        
        
        let rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextButtonPressed(_:)))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func nextButtonPressed(_ barItem: UIBarButtonItem) {
        
    }
    
    func termsOfServiceTapGesture(_ gesture: UITapGestureRecognizer) {
        
    }
    
    
}
