//
//  LoginCountriesController.swift
//  OceanApp
//
//  Created by rookie on 2016/12/5.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class LoginCountriesController: UITableViewController {
    
    static var countryCodes: [[String]] = {
        
        let filePath = Bundle.main.path(forResource: "PhoneCountries", ofType: "txt")
        var stringData : NSString? = nil
        do {
            stringData = try NSString(contentsOfFile: filePath!, encoding: 4)
        }catch {}
        
        
        let delimiter = ";"
        let endOfLine = "\n"
        
        var array = [[String]]()
        
        var currentLocation = 0
        while true {
            let _range = NSMakeRange(currentLocation, stringData!.length - currentLocation)
            let codeRange = stringData?.range(of: delimiter, options: String.CompareOptions(rawValue: 0), range: _range, locale: nil)
            
            if codeRange?.location == NSNotFound {
                break
            }
            
            let countryCode = stringData?.substring(with: NSMakeRange(currentLocation, codeRange!.location - currentLocation))
            
            let _idRange = NSMakeRange(codeRange!.location + 1, stringData!.length - codeRange!.location - 1)
            let idRange = stringData?.range(of: delimiter, options: String.CompareOptions(rawValue: 0), range: _idRange, locale: nil)
            
            if idRange?.location == NSNotFound {
                break
            }
            
            let countryId = stringData?.substring(with: NSMakeRange( codeRange!.location + 1, idRange!.location - (codeRange!.location + 1))).lowercased()
            
            let _nameRange = NSMakeRange(idRange!.location + 1, stringData!.length - (idRange!.location + 1))
            var nameRange = stringData!.range(of: endOfLine, options:  String.CompareOptions(rawValue: 0), range: _nameRange, locale: nil)
            if nameRange.location == NSNotFound {
                nameRange = NSMakeRange(stringData!.length, 50)
            }
            
            var countryName = stringData!.substring(with: NSMakeRange(idRange!.location + 1, nameRange.location - (idRange!.location + 1)))
            if countryName.hasSuffix("\r") {
                countryName = countryName.substring(to: countryName.index(countryName.endIndex, offsetBy: -1))
            }
            
            array.append([countryCode!,countryId!,countryName])
            
            currentLocation = Int ( nameRange.location + nameRange.length )
            if nameRange.length > 1 {
                break
            }
        }
        
        return array
    }()
    
    class func countryName(code: Int) -> String? {
        
        for array in LoginCountriesController.countryCodes {
            if Int( array[0])! == code {
                return array[2]
            }
        }
        
        return nil
    }
    
    class func countryName(countryId: String, code: inout Int) -> String? {
        let _country =  LoginCountriesController.countryCodes.filter { (country) -> Bool in
            if country[1] == countryId.lowercased() {
                code = Int ( country[0] )!
                return true
            } else {
                return false
            }
        }
        if _country.count > 0 {
            return _country[0][2]
        } else {
            return nil
        }
    }
    
    
    
    
    var sections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
    
}

extension LoginCountriesController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
    
    
    
    
    
}




















