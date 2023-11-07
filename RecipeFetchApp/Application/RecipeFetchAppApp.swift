//
//  RecipeFetchAppApp.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/3/23.
//

import SwiftUI

@main
struct RecipeFetchAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
