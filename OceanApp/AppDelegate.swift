//
//  AppDelegate.swift
//  OceanApp
//
//  Created by rookie on 2016/11/18.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit
//import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let tabBarViewController = TabBarViewController()
        window.rootViewController = tabBarViewController
        window.makeKeyAndVisible()
        
        let hasLogin = false
        
        if !hasLogin {
            presentLoginController("18612259290")
        }
        readingPreferenceSetting()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //self.saveContext()
    }

    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
    
    /*
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "OceanApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    */
    
    lazy var loginNavigationController: UINavigationController = {
        return UINavigationController(navigationBarClass: OcTransparentNavigationBar.self, toolbarClass: nil)
    }()
    
    func presentLoginController(_ phoneNumber: String) {
        
        if !Thread.isMainThread {
            performSelector(onMainThread: #selector(presentLoginController(_:)), with: phoneNumber, waitUntilDone: true)
        }
        
        let viewControllers = [LoginViewController()]
        loginNavigationController.setViewControllers(viewControllers, animated: false)
        window.rootViewController!.present(loginNavigationController,
                                           animated: UIApplication.shared.applicationState == .active,
                                           completion: nil)
        
    }
    
    
    
    lazy var documentsPath : String = {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }()
    
}


extension AppDelegate {
    
    func readingPreferenceSetting() {
        
        let settingsBundle = Bundle.main.path(forResource: "Settings", ofType: "bundle")
        guard let _ = settingsBundle else {
            return
        }
    }
    

    func loadLoginState() -> Dictionary<String, Any>? {
        return NSDictionary(contentsOfFile: documentsPath + "state.data") as! Dictionary<String, Any>?
    }
    
    func saveLoginStateWith(date:Int,
                            phoneNumber:String,
                            phoneCode:String,
                            firstName:String,
                            lastName:String,
                            photo:Data?)  {
        
        let stateDic = ["version": date,
                        "phoneNumber":phoneNumber,
                        "phoneCode":phoneCode,
                        "firstName":firstName,
                        "lastName":lastName,
                        "photo": photo ?? Data()] as [String : Any]
        
        NSDictionary(dictionary: stateDic).write(toFile: documentsPath + "state.data", atomically: true)
    }
    
    

}





