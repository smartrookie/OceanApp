//
//  PatientDetailController.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/8.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit

class PatientDetailController: UIViewController {
    
    var patient: SWPatient! {
        didSet {
//            personCell.configureForObject(object: patient)
//            fingersCell.configureForObject(object: patient)
//            markCell.configureForObject(object: patient)
            
            detailCell.configureForObject(object: patient)
            tableView.reloadData()
        }
    }
    
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    var sections = [[OcTableViewCell]]()
    
    let detailCell = PatientDetailCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "详细资料"
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        

        sections.append([detailCell])
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let rightBarButtonItem = UIBarButtonItem(title: "操作", style: .plain, target: self, action: #selector(rightBarButtonPressed))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func rightBarButtonPressed() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let delete = UIAlertAction(title: "删除", style: .destructive) { [unowned self](_) in
            
            let deleteAlert = UIAlertController(title: "确认删除？", message:"删除操作将无法恢复！", preferredStyle: .alert)
            let confirmDelete = UIAlertAction(title: "确认删除", style: .destructive, handler: { [unowned self](_) in
                self.patient.managedObjectContext?.performChanges {
                    self.patient.managedObjectContext?.delete(self.patient)
                    let _ = self.navigationController?.popViewController(animated: true)
                }
            })
            let cancelDelete = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            deleteAlert.addAction(cancelDelete)
            deleteAlert.addAction(confirmDelete)
            
            self.present(deleteAlert, animated: true, completion: nil)
        }
        
        let modify = UIAlertAction(title: "修改", style: .default) { [unowned self](_) in
            let modifyController = AddPatientController()
            modifyController.patient = self.patient
            let navi = UINavigationController(rootViewController: modifyController)
            self.present(navi, animated: false, completion: nil)
        }
        
        alertController.addAction(modify)
        alertController.addAction(delete)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension PatientDetailController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = sections[indexPath.section][indexPath.row]
        
        return cell
    }
}

extension PatientDetailController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section][indexPath.row].height
    }
}
