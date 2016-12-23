//
//  AppDelegate.swift
//  SocialSample
//
//  Created by Julian Gruber on 12/12/2016.
//  Copyright © 2016 Quikkly Ltd. All rights reserved.
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
        
        Quikkly.apiKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" //insert your API key
        Quikkly.user = Quikkly.User(withId: 0, gender: "Female", dob: "08-03-1985") //set user data for insights model 
        
        return true
    }

}

