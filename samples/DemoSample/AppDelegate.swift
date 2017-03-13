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
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Quikkly framework setup
        Quikkly.apiKey = "kCPeTZnGsmo90ZAu9q2rlXB94EAbUC2fvK7Ur95tLHsKFIYhYdt8Qrl80iVy" //Insert your api key here
        
        let tabVC = UITabBarController()
        let vc0 = CustomScanViewController()
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

