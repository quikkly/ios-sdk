//
//  AppDelegate.swift
//  DemoSample
//
//  Created by Julian Gruber on 06/03/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Quikkly framework setup
        QuikklyApi.apiKey = nil //api key no longer relevant
        let tabVC = UITabBarController()
        let vc0 = ScanContextViewController()
        vc0.tabBarItem = UITabBarItem(title: "Scanning", image: UIImage(named: "Image-TabBar-Scanning"), tag: 0)
        let vc1 = UINavigationController(rootViewController: GenerateViewController())
        vc1.tabBarItem = UITabBarItem(title: "Generating", image: UIImage(named: "Image-TabBar-Generating"), tag: 1)
        tabVC.viewControllers = [vc0, vc1]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabVC
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()

        
        return true
    }


}

