//
//  GenerateViewController.swift
//  Samples
//
//  Created by Julian Gruber on 06/03/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly

class GenerateViewController: UIViewController {

    var scannableView:ScannableView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Generate"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.scannableView = ScannableView(frame: CGRect())
        self.view.addSubview(self.scannableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Generate scannable
        let skin = ScannableSkin()
        skin.backgroundColor = "#3299FF"
        skin.dataColors = ["#FFFFFF" ]
        skin.borderColor = "#444444"
        skin.imageUri = "https://s3-eu-west-1.amazonaws.com/docs.quikkly.io/img/1481647718.png"
        let scannable = Scannable(withValue: 123456789, template:nil, skin: skin)
        self.scannableView.scannable = scannable
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect()
        
        rect.size.width = self.view.frame.size.width
        rect.size.height = self.view.frame.size.height*0.33
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.view.frame.size.height*0.5 - rect.size.height*0.5
        self.scannableView.frame = rect
    }

}
