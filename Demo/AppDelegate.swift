//
//  AppDelegate.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaults.standard.object(forKey: "collectionLibrary") != nil {
            
            collectionLibrary = UserDefaults.standard.dictionary(forKey: "collectionLibrary") as! Dictionary<String, Dictionary<String, String>>
        }
        return true
    }
}

