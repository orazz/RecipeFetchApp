//
//  AppDelegate.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/4/23.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let container = DIContainerImpl()
        ViewModelFactory.shared.register(DIContainer: container)
        
        return true
    }
}
