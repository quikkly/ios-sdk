//
//  CustomScanViewController.swift
//  Samples
//
//  Created by Julian Gruber on 13/12/2016.
//  Copyright © 2016 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly


class CustomScanViewController: UIViewController, ScanViewDelegate {

    var scanView:ScanView!
    var viewFinderView:ViewFinderView!
    var activityIndicatorView:UIActivityIndicatorView!
    var dismissButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scanView = ScanView(frame: CGRect())
        self.scanView.delegate = self
        self.view.addSubview(self.scanView)
        
        self.viewFinderView = ViewFinderView(frame: CGRect())
        self.view.addSubview(self.viewFinderView)
        
        self.dismissButton = UIButton(frame: CGRect())
        self.dismissButton.setImage(UIImage(named:"Image-Cancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.dismissButton.tintColor = .white
        self.dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        self.view.addSubview(self.dismissButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect()
        
        rect.origin.x = 0
        rect.origin.y = 0
        rect.size.width = self.view.frame.size.width
        rect.size.height = self.view.frame.size.height
        self.scanView.frame = rect
        
        rect.size.width = self.view.frame.size.width*0.75
        rect.size.height = rect.size.width
        self.viewFinderView.frame = rect
        self.viewFinderView.center.x = self.view.frame.size.width*0.5
        self.viewFinderView.center.y = self.view.frame.size.height*0.5
        
        rect.size.width = 45
        rect.size.height = 45
        rect.origin.x = 15
        rect.origin.y = 30
        self.dismissButton.frame = rect
        self.dismissButton.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7)
    }
    
    @IBAction func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - ScanViewDelegate
    
    func scanView(_ scanView: ScanView, didDetectScannables scannables: [Scannable]) {
        if let scannable = scannables.first, let user = User.storedUser(withId: scannable.value.intValue) {
            let presentingVC = self.presentingViewController
            self.dismiss(animated: true, completion: {
                let vc = ProfileViewController(withUser: user)
                vc.title = "Scanned Profile"
                if let nav = presentingVC as? UINavigationController {
                    nav.pushViewController(vc, animated: true)
                } else {
                    presentingVC?.navigationController?.pushViewController(vc, animated: true)
                }
            })
        }
    }

}
