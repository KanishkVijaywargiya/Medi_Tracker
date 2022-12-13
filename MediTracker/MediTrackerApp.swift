//
//  MediTrackerApp.swift
//  MediTracker
//
//  Created by Kanishk Vijaywargiya on 11/12/22.
//

import SwiftUI
import Firebase

@main
struct MediTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //    init() {
    //        FirebaseApp.configure()
    //    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: Setting up the firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
}

