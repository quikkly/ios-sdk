//
//  ScanContextViewController.swift
//  Samples
//
//  Created by Julian Gruber on 13/03/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly

class ScanContextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
        button.center = self.view.center
        button.setTitle("Scan", for: .normal)
        button.addTarget(self, action: #selector(presentScanViewController), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func presentScanViewController() {
        self.present(CustomScanViewController(), animated: true) { 
            
        }
    }

}
