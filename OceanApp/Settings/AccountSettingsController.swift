//
//  AccountSettingsController.swift
//  OceanApp
//
//  Created by rookie on 2016/12/15.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class AccountSettingsController: UIViewController {
    
    var sections = [[UITableViewCell]]()
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    let setProfilePhotoCell = UITableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = UIColor.white

        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(tableView)
        
        
        let accountCell = AccountInfoTableViewCell()
        setProfilePhotoCell.textLabel?.text = "设置头像"
        setProfilePhotoCell.textLabel?.textColor = UIColor.oc_accentColor()
        
        sections.append([accountCell,setProfilePhotoCell])
        
        let logoutCell = LogoutTableViewCell()
        logoutCell.action = #selector(logoutPressed)
        sections.append([logoutCell])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logoutPressed() {
        debugPrint("logout pressed")
        (UIApplication.shared.delegate as! AppDelegate).presentLoginController("")
    }

}

extension AccountSettingsController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = sections[indexPath.section][indexPath.row]
        
        if cell is AccountInfoTableViewCell {
            return 96
        }
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section][indexPath.row]
    }
}


extension AccountSettingsController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        if selectedCell is LogoutTableViewCell {
            perform((selectedCell as! LogoutTableViewCell).action)
        }
        else if selectedCell == setProfilePhotoCell {
            setProfilePhotoPressed()
        }
        
    }
    
    func setProfilePhotoPressed() {
        
    }
}
