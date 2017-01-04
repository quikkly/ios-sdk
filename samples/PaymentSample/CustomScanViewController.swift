//
//  CustomScanViewController.swift
//  Samples
//
//  Created by Julian Gruber on 12/01/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly

class CustomScanViewController: UIViewController, ScanViewDelegate, ActionProcessorDelegate {

    var scanView:ScanView!
    var actionProcessor:ActionProcessor!
    var viewFinderView:ViewFinderView!
    var activityView: UIActivityIndicatorView!
    var scanLabel:UILabel!
    var bottomView:UIView!
    var dismissButton:UIButton!
    
    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get {
            return .portrait
        }
    }
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x:0, y:0, width:375, height:667)
        
        self.scanView = ScanView(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height))
        self.scanView.delegate = self
        self.view.addSubview(self.scanView)
        
        self.actionProcessor = ActionProcessor()
        self.actionProcessor.delegate = self
        
        self.viewFinderView = ViewFinderView(frame: CGRect())
        self.view.addSubview(self.viewFinderView)
        
        self.bottomView = UIView(frame: CGRect())
        self.bottomView.backgroundColor = .white
        self.bottomView.layer.shadowColor = UIColor.black.cgColor
        self.bottomView.layer.shadowOpacity = 0.35
        self.bottomView.layer.shadowOffset = CGSize.zero
        self.bottomView.layer.shadowRadius = 1.5
        self.view.addSubview(self.bottomView)
        
        self.activityView = UIActivityIndicatorView(frame: CGRect())
        self.activityView.activityIndicatorViewStyle = .gray
        self.activityView.color = .black
        self.bottomView.addSubview(self.activityView)
        
        self.scanLabel = UILabel(frame: CGRect())
        self.scanLabel.text = "Scanning".uppercased()
        self.scanLabel.textColor = self.activityView.color
        self.scanLabel.textAlignment = .center
        self.bottomView.addSubview(self.scanLabel)
        
        self.dismissButton = UIButton(type: .custom)
        self.dismissButton.setImage(UIImage(named: "Icon-Cancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.dismissButton.imageView?.tintColor = self.activityView.color
        self.dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        self.bottomView.addSubview(self.dismissButton)
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scanView.start()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.scanView.stop()
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.scanView.stop()
    }
    
    //MARK: - Layout
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect()
        
        rect.size.height = 60
        rect.origin.x = 0
        rect.size.width = self.view.frame.size.width
        rect.origin.y = self.view.frame.size.height - rect.size.height
        self.bottomView.frame = rect
        self.bottomView.layer.shadowPath = UIBezierPath(rect: self.bottomView.bounds).cgPath
        
        rect.origin.x = 0
        rect.origin.y = 0
        rect.size.width = self.view.frame.size.width
        rect.size.height = self.view.frame.size.height - self.bottomView.frame.size.height
        self.scanView.frame = rect
        
        rect.size.height = 55
        rect.size.width = rect.size.height
        self.activityView.frame = rect
        self.activityView.center.x = self.bottomView.frame.size.width*0.5
        self.activityView.center.y = self.bottomView.frame.size.height*0.5
        
        rect.size.width = min(self.view.frame.size.width*0.75, self.view.frame.size.height*0.75)
        rect.size.height = rect.size.width
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = (self.view.frame.size.height - self.bottomView.frame.size.height)*0.5 - rect.size.height*0.5
        self.viewFinderView.frame = rect
        
        rect.size.height = 40
        rect.size.width = rect.size.height
        rect.origin.y = self.bottomView.frame.size.height*0.5 - rect.size.height*0.5
        rect.origin.x = rect.origin.y
        self.dismissButton.frame = rect
        self.dismissButton.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12)
        
        rect.size.height = 40
        rect.size.width = 100
        rect.origin.y = self.bottomView.frame.size.height*0.5 - rect.size.height*0.5
        rect.origin.x = self.bottomView.frame.size.width*0.5 - rect.size.width*0.5
        self.scanLabel.frame = rect
    }
    
    //MARK: - Action
    
    func dismissPresentedVC() {
        self.presentedViewController?.dismiss(animated: true, completion: {})
    }
    
    @IBAction
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - ScanViewDelegate
    
    public func scanView(_ scanView: ScanView, didDetectScannables scannables: [Scannable]) {
        if let scannable = scannables.first {
            self.actionProcessor.process(scannable: scannable)
        }
    }
    
    //MARK: - ActionProcessorDelegate
    
    fileprivate var isVCPresented:Bool = false
    public func actionProcessorWillStartProcessing(_ actionProcessor: ActionProcessor) {
        self.scanLabel.isHidden = true
        self.activityView.isHidden = false
        self.activityView.startAnimating()
    }
    
    public func actionProcessor(_ actionProcessor: ActionProcessor, didProcessAction action: Action?, withResult result: ActionResult) {
        if !self.isVCPresented {
            self.scanLabel.isHidden = false
        }
        self.activityView.isHidden = true
        self.activityView.stopAnimating()
    }
    
    public func actionProcessor(_ actionProcessor: ActionProcessor, willPresentActionResultViewController viewController: UIViewController) {
        self.isVCPresented = true
        self.scanLabel.isHidden = true
        self.scanView.stop()
    }
    
    public func actionProcessor(_ actionProcessor: ActionProcessor, didDismissActionResultViewController viewController: UIViewController) {
        self.isVCPresented = false
        self.scanLabel.isHidden = false
        self.scanView.start()
    }
    
    func actionProcessor(_ actionProcessor: ActionProcessor, customActionForData data: [String : Any]) -> Action {
        // This is where the action handling of a custom payment tag is defined
        if let walletId = data["wallet"] as? Int, let amount = data["amount"] as? Float {
            return PaymentAction(withWalletId: walletId, amount: amount)
        }
        
        return Action()
    }


}
