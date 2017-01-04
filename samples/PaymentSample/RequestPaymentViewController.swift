//
//  RequestPaymentViewController.swift
//  Samples
//
//  Created by Julian Gruber on 12/01/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly

class RequestPaymentViewController: UIViewController, UITextFieldDelegate {

    var valueTextField:UITextField!
    var scannableView:ScannableView!
    var activityIndicatorView:UIActivityIndicatorView!
    var activityLabel:UILabel!
    var scannable:Scannable?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Request Money"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.valueTextField = UITextField(frame: CGRect())
        self.valueTextField.placeholder = "Enter £ value to be paid"
        self.valueTextField.keyboardType = .numberPad
        self.valueTextField.textAlignment = .center
        let tfToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        tfToolbar.barStyle = .default
        tfToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        ]
        tfToolbar.sizeToFit()
        self.valueTextField.inputAccessoryView = tfToolbar
        self.view.addSubview(self.valueTextField)
        
        self.scannableView = ScannableView(frame: CGRect())
        self.view.addSubview(self.scannableView)
        
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activityIndicatorView.isHidden = true
        self.view.addSubview(self.activityIndicatorView)
        
        self.activityLabel = UILabel(frame: CGRect())
        self.activityLabel.isHidden = true
        self.activityLabel.textColor = .gray
        self.activityLabel.textAlignment = .center
        self.view.addSubview(self.activityLabel)
    }
    
    @IBAction
    func cancelPressed() {
        self.valueTextField.resignFirstResponder()
        self.valueTextField.text = ""
    }
    
    @IBAction
    func donePressed() {
        self.valueTextField.resignFirstResponder()
        self.generateScannable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect()
        
        rect.size.height = 35
        rect.size.width = self.view.frame.size.width*0.75
        self.valueTextField.frame = rect
        self.valueTextField.center.x = self.view.frame.size.width*0.5
        self.valueTextField.center.y = self.view.frame.size.height*0.25
        
        rect.size.height = self.view.frame.size.height*0.3
        rect.size.width = rect.size.height
        self.scannableView.frame = rect
        self.scannableView.center.x = self.view.frame.size.width*0.5
        self.scannableView.center.y = self.view.frame.size.height*0.6
        
        rect.size.height = 50
        rect.size.width = rect.size.height
        self.activityIndicatorView.frame = rect
        self.activityIndicatorView.center.x = self.view.frame.size.width*0.5
        self.activityIndicatorView.center.y = self.view.frame.size.height*0.6
        
        rect.size.height = 30
        rect.size.width = self.view.frame.size.width*0.9
        rect.origin.y = self.activityIndicatorView.frame.origin.y + self.activityIndicatorView.frame.size.height + 5
        self.activityLabel.frame = rect
        self.activityLabel.center.x = self.view.frame.size.width*0.5
    }
    
    // MARK: - Actions
    
    @IBAction
    func generateScannable() {
        
        if let text = self.valueTextField.text, let value = Float(text) {
            var skin = ScannableSkin()
            // creating scannable with value from the text field and the user's wallet id (in this case hard coded for simplicity)
            self.scannable = Scannable(withAction: PaymentAction(withWalletId:1234, amount:value), skin: skin) { (success, scannable) in
                if success && scannable == self.scannable {
                    self.scannableView.scannable = scannable
                    self.scannableView.isHidden = false
                }
                self.activityIndicatorView.isHidden = true
                self.activityLabel.isHidden = true
                self.activityIndicatorView.stopAnimating()
            }
            self.activityLabel.text = "Generating payment scannable"
            self.activityIndicatorView.isHidden = false
            self.activityLabel.isHidden = false
            self.activityIndicatorView.startAnimating()
            self.scannableView.isHidden = true
        }
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.valueTextField.resignFirstResponder()
        self.generateScannable()
        return true
    }

}
