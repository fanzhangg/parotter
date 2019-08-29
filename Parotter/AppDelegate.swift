//
//  AppDelegate.swift
//  Parotter
//
//  Created by Fan Zhang on 8/21/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import UIKit
import SwifteriOS
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// Handle callback url
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:])-> Bool {
        os_log("Opening callback url: %s", url.absoluteString)
        if url.absoluteString.starts(with: "parotter://success") {
            // self.pushHomeBarController()
            os_log("Opening HomeBarView")
            Swifter.handleOpenURL(url)
        } else {
            fatalError("Unhandled callback url")
        }
        return true
    }
    
    /// Set the entry view depending on the authroization
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if NetworkHelper.accessToken != nil { // Enter the HomeBarView if the authorization has been completed
//            self.enterHomeBarView()
//
//        } else {    // Eter the AuthView if authrization needed
//            let authViewController = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController   // Create an instance of AuthViewController
//            self.window?.rootViewController = authViewController
//        }
        return true
    }
    
//    /// Push the HomeBarController after opening callback url
//    func pushHomeBarController() {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let homeBarController = storyboard.instantiateViewController(withIdentifier: "HomeBarController") as! HomeBarController   // Create an instance of HomeBarController
//            let navController = self.window?.rootViewController?.navigationController as! UINavigationController
//            navController.pushViewController(homeBarController, animated: true) // Push HomeBarController
//    }
    
//    func enterHomeBarView() {
//        let failureHandler: (Error) -> Void = {error in
//            os_log("Fail to fetch home stream", log: OSLog.default, type: .default)
//        }
//        // Get tweets
//        NetworkHelper.swifter.getHomeTimeline(count: 20, success: {json in
//            os_log("Fetching tweets...", log: OSLog.default, type: .debug)
//            guard let tweets = json.array else {
//                os_log("Fail to retrieve tweets", log: OSLog.default, type: .debug)
//                return
//            }
//            NetworkHelper.tweets = tweets
//            // Initialize HomeBarView
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let homeBarController = storyboard.instantiateViewController(withIdentifier: "HomeBarController") as! HomeBarController   // Create an instance of HomeBarController
//            self.window?.rootViewController = homeBarController
//            
//        }, failure: failureHandler)
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

