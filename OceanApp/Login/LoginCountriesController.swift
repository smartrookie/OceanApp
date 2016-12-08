//
//  LoginCountriesController.swift
//  OceanApp
//
//  Created by rookie on 2016/12/5.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit
import BLPhoneFormat

class LoginCountriesController: UITableViewController {
    
    var countryCodeSelectedBlock : ((_ country: BLCountry)->Void)?
    

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
    

    class OcCountrySection : AnyObject {
        var headerView : UIView?
        var title      : Character?
        var items      = [BLCountry]()
    }
    
    var sections = [OcCountrySection]()
    var searchResults = [BLCountry]()
    var sectionIndexTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Country"
        
        var sectionDict = [Character:OcCountrySection]()
        
        for country in BLCountriesUtils.countryCodes() {
            
            let country : BLCountry = country as! BLCountry
            let key = country.name.characters.first
            
            var section = sectionDict[key!]
            
            if let _ = section {
                section!.items.append(country)
            } else {
                section = OcCountrySection()
                section!.title = key!
                section!.items.append(country)
                sections.append(section!)
            }
            sectionDict[key!] = section
        }
        
        sections.sort { (section1, section2) -> Bool in
            return section1.title! <= section2.title!
        }

        sectionIndexTitles.append(UITableViewIndexSearch)
        
        var isFirst = true
        sections.forEach { (section) in
            sectionIndexTitles.append(String(section.title!))
            section.headerView = generateSectionHeader(title: String(section.title!), isFirst: isFirst)
            isFirst = false
            section.items.sort { (country1, country2) -> Bool in
                    switch country1.name.compare(country2.name, options: [String.CompareOptions.forcedOrdering
                        ,String.CompareOptions.caseInsensitive], range: nil, locale: nil) {
                    case .orderedAscending,.orderedSame :
                        return true
                    case .orderedDescending :
                        return false
                    }
            }
        }
        
        tableView.register(LoginContryCell.self, forCellReuseIdentifier: "cell")
        
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed(_:)))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let searchController = UISearchController(searchResultsController: self)
        searchController.searchBar.backgroundColor = UIColor.clear
        tableView.tableHeaderView = searchController.searchBar
        searchController.delegate = self
    }
    
    func generateSectionHeader(title: String, isFirst: Bool) -> UIView? {
        
        let sectionContainer = UIView()
        
        sectionContainer.frame = CGRect(x: 0, y: isFirst ? -1 : 0, width: 10, height: isFirst ? 11 : 10)
        sectionContainer.clipsToBounds = false
        sectionContainer.isOpaque = false
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        sectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        sectionView.backgroundColor = UIColor.color(hex: "0xf7f7f7")
        sectionContainer.addSubview(sectionView)
        
        let sectionLabel = UILabel()
        sectionLabel.font = UIFont.systemFont(ofSize: 17)
        sectionLabel.backgroundColor = sectionView.backgroundColor
        sectionLabel.textColor = UIColor.black
        sectionLabel.numberOfLines = 1
        
        sectionLabel.text = title
        sectionLabel.frame = sectionLabel.frame.offsetBy(dx: 14, dy: 0.5)
        sectionLabel.sizeToFit()
        sectionContainer.addSubview(sectionLabel)
        
        return sectionContainer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func cancelButtonPressed(_ item:UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}




extension LoginCountriesController {
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if tableView == self.tableView {
            return sectionIndexTitles
        } else {
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView {
            return sections.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return sections[section].items.count
        } else {
            return searchResults.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.tableView {
            return 25
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.tableView {
            return sections[section].headerView
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var country : BLCountry
        if tableView == self.tableView {
            country = sections[indexPath.section].items[indexPath.row]
        } else {
            country = searchResults[indexPath.row]
        }
        
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = "+" + "\(country.code)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = sections[indexPath.section].items[indexPath.row]
        countryCodeSelectedBlock?(country)
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if tableView == self.tableView {
            if index == 0 {
                tableView.scrollRectToVisible(tableView.tableHeaderView!.frame, animated: true)
            }
            return index - 1
        }
        return 0
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            view.endEditing(true)
        } else {
            view.endEditing(true)
        }
    }
    
}

extension LoginCountriesController : UISearchBarDelegate , UISearchDisplayDelegate , UISearchControllerDelegate{
    
    
    
    
    
}


class LoginContryCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 17)
        detailTextLabel?.textColor = UIColor.black
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

















