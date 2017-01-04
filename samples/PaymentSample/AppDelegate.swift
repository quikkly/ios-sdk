//
//  AppDelegate.swift
//  PaymentSample
//
//  Created by Julian Gruber on 11/01/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: HomeViewController())
        self.window?.rootViewController = nav
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        Quikkly.apiKey = "wpfiila4f2kczht0pe3xerxil37mz6uorlnxt2ci1u9ekkgnwsrja8yed81s" //insert your own API key
        Quikkly.user = Quikkly.User(withId: 0, gender: "Female", dob: "08-03-1985") //set user data for insights model
        
        return true
    }
}

