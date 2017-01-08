//
//  PatientsListController.swift
//  OceanApp
//
//  Created by 张东风 on 2017/1/4.
//  Copyright © 2017年 rookie. All rights reserved.
//

import UIKit
import CoreData

class PatientsListController: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    var listItems = [OcPatient]()
    

    
    var managerObjectContext : NSManagedObjectContext?
    typealias Data = SWFetchedResultDataProvider<PatientsListController>
    var dataSource : SWTableViewDataSource<PatientsListController, Data, PatientListCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Patients"
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        tableView.delegate = self
        view.addSubview(tableView)
        
        managerObjectContext = SWCoreData().createMoodyMainContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: SWPatient.entityName)
        let sortDescriptor = NSSortDescriptor(key: "createTime", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.fetchBatchSize = 20
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managerObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        let dataProvider = SWFetchedResultDataProvider(fetchResultsController: frc, delegate: self)
        dataSource = SWTableViewDataSource<PatientsListController, Data, PatientListCell>(tableView: tableView, dataProvider: dataProvider, delegate: self)

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        tableView.register(PatientListCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addButtonPressed() {
        let addC = AddPatientController()
        addC.managerObjectContext = managerObjectContext
        let navi = UINavigationController(rootViewController: addC)
        present(navi, animated: true, completion: nil)
    }

    
}

extension PatientsListController : SWDataSourceDelegate {
    func cellIdentifierForObject(object: SWPatient) -> String {
        return "cell"
    }
}

extension PatientsListController : SWDataProviderDelegate {
    func dataProviderDidUpdate(updates: [SWDataProviderUpdate<SWPatient>]) {
        dataSource?.processUpdates(updates: updates)
    }
}

extension PatientsListController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let patient = dataSource?.dataProvider.objectAtIndexPath(indexPath: indexPath)
        let detailController = PatientDetailController()
        navigationController?.pushViewController(detailController, animated: true)
        detailController.patient = patient
    }
}



