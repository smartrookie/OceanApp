//
//  ContactsController.swift
//  OceanApp
//
//  Created by rookie on 2016/12/16.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit
import Contacts

class ContactsController: UIViewController {
    
    var contacts = [String]()
    
    let tableView = UITableView(frame: CGRect.zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        view.backgroundColor = UIColor.white

        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        
        tableView.register(OcContactCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        
        
        contacts = ["张学林","smartrookie","Spam Info Bot","Name Hidden"]
        
        
        
        
        
        
        //updatePhonebookAccess()
    }
    /*
    func updatePhonebookAccess() {
        ocContactsManager.requestContactsAuthorization({ (enable) in
            
            if !enable {
                let accessOverlay = UIView(frame: self.view.bounds)
                accessOverlay.autoresizingMask = [.flexibleWidth,.flexibleHeight]
                accessOverlay.backgroundColor = UIColor.color(hex: "0xefeff4")
                
                let container = UIView(frame: CGRect(x: (accessOverlay.frame.width - 40) / 2,
                                                     y: (accessOverlay.frame.height - 4) / 2,
                                                     width: 40,
                                                     height: 4))
                container.tag = 100
                container.autoresizingMask = [.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleBottomMargin]
                container.clipsToBounds = true
                accessOverlay.addSubview(container)
                
                let titleLabel = UILabel()
                titleLabel.tag = 300
                titleLabel.backgroundColor = UIColor.clear
                titleLabel.font = UIFont.systemFont(ofSize: 17)
                titleLabel.textColor = UIColor.color(hex: "0x999999")
                titleLabel.text = "Does not have access to your contacts"
                container.addSubview(titleLabel)
                
                let subtitleLabel = UILabel()
                subtitleLabel.tag = 400
                subtitleLabel.backgroundColor = UIColor.clear
                subtitleLabel.font = UIFont.systemFont(ofSize: 14)
                subtitleLabel.textColor = UIColor.color(hex: "0x999999")
                subtitleLabel.numberOfLines = 0
                subtitleLabel.textAlignment = .center
                
                container.addSubview(subtitleLabel)
                self.view.addSubview(container)
                
                
            } else {
                do {
//                    let groups = try contactsStore.groups(matching: nil)
                    let predicate = CNContact.predicateForContactsInGroup(withIdentifier: "")
                    //let predicate = CNContact.predicateForContactsMatchingName("John")
                    
                    let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
                    
                    let contacts = try contactsStore.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
                    self.contacts = contacts
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            }
        })
    }*/
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContactsController : UITableViewDelegate {
    
    
    
    
    
}

extension ContactsController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row]
        
        return cell
    }
    
}
