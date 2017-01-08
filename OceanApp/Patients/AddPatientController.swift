//
//  AddPatientController.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/4.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit
import CoreData

class AddPatientController: UITableViewController , SWManagedObjectContextSettable{
    
    var managerObjectContext: NSManagedObjectContext!
    
    
    
    var sections = [[OcTableViewCell]]()
    
    
    private let fingerCell = AddPatientFingerCell()
    private let markCell = OcMutilineInputCell()
    private let personCell = AddPatientPersonCell()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "新增"
        
        let rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        tableView.register(OcTableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        sections.append([personCell])
        
        sections.append([fingerCell])
        
        markCell.selectionStyle = .none
        markCell.placeholder = "Description"
        sections.append([markCell])
        markCell.heightChanged = { [unowned self] in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            let indexPath = self.tableView.indexPath(for: self.markCell)
            self.tableView.scrollToRow(at: indexPath!, at: .bottom, animated: true)
        }
        
        
        tableView.keyboardDismissMode = .interactive
        tableView.tableFooterView = UIView()
    }
    
    func doneButtonPressed() {
        
        let name = personCell.nameField.text
        let sex  = personCell.sex
        let date = Date()
        let mark = markCell.textView.text
        let fingers = fingerCell.fingerFlag
        
        managerObjectContext.performChanges {
            let patient : SWPatient = self.managerObjectContext.insertObject()
            patient.name = name
            patient.sex = sex.rawValue
            patient.createTime = date as NSDate?
            patient.mark = mark
            patient.fingers = fingers as NSObject?
            
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
var _height : CGFloat = 0

extension AddPatientController {
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = sections[indexPath.section][indexPath.row].height
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = sections[indexPath.section][indexPath.row]
        return cell
    }
    
}
