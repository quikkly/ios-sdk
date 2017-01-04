//
//  ViewController.swift
//  PaymentSample
//
//  Created by Julian Gruber on 11/01/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var requestPaymentButton:UIButton!
    var scanbutton:UIButton!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Home"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.requestPaymentButton = UIButton(type: .system)
        self.requestPaymentButton.setTitle("Request Money", for: .normal)
        self.requestPaymentButton.addTarget(self, action: #selector(requestPaymentButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.requestPaymentButton)
        
        self.scanbutton = UIButton(type: .system)
        self.scanbutton.setTitle("Scan to Send Money", for: .normal)
        self.scanbutton.addTarget(self, action: #selector(scanButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.scanbutton)
    }
    
    // MARK: - Actions
    
    @IBAction func scanButtonPressed() {
        self.present(CustomScanViewController(), animated: true, completion: nil)
    }
    
    @IBAction func requestPaymentButtonPressed() {
        self.navigationController?.pushViewController(RequestPaymentViewController(), animated: true)
    }
    
    
    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect()
        
        rect.origin.x = 0
        rect.size.width = self.view.frame.size.width
        rect.size.height = 35
        rect.origin.y = self.view.frame.size.height*0.5 - rect.size.height - 10
        self.requestPaymentButton.frame = rect
        
        rect.origin.x = 0
        rect.size.width = self.view.frame.size.width
        rect.size.height = 35
        rect.origin.y = self.view.frame.size.height*0.5 + 10
        self.scanbutton.frame = rect
    }


}

