//
//  AppDelegate.swift
//  KeyboardListener
//
//  Created by 刘畅 on 2022/5/31.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        // Override point for customization after application launch.
        return true
    }



}

