//
//  CompletionViewController.swift
//  Samples
//
//  Created by Julian Gruber on 16/01/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly


class CompletionViewController: ActionResultViewController {
    
    var imageView:UIImageView!
    var titleLabel:UILabel!
    var descriptionLabel:UILabel!
    var button:UIButton!
    
    var walletId:Int?
    var amount:Float?
    
    init(withWalletId wallet:Int, amount:Float) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Payment Successful"
        
        self.walletId = wallet
        self.amount = amount
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.imageView = UIImageView(image: UIImage(named:"Image-Success")?.withRenderingMode(.alwaysTemplate))
        self.imageView.contentMode = .scaleAspectFit
        self.view.addSubview(self.imageView)
        
        self.titleLabel = UILabel(frame: CGRect())
        self.titleLabel.font = UIFont.systemFont(ofSize: 15.5)
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = "Payment successful"
        if let x = self.amount {
            self.titleLabel.text = "You've paid £\(x) to"
        }
        self.view.addSubview(self.titleLabel)
        
        self.descriptionLabel = UILabel(frame: CGRect())
        self.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.descriptionLabel.textAlignment = .center
        if let x = self.walletId {
            if x == 1234 {
                self.descriptionLabel.text = "Albus Dumbledore"
            }
        }
        self.view.addSubview(self.descriptionLabel)
        
        self.button = UIButton(type: .system)
        self.button.setTitle("Yay!", for: .normal)
        self.button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.button.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        self.view.addSubview(self.button)
    }
    
    @IBAction
    func donePressed() {
        self.dismiss(animated: true) { 
            self.delegate?.didDismissViewController?(self)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect()
        
        rect.size.height = 100
        rect.size.width = rect.size.height
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.view.frame.size.height*0.25 - rect.size.height*0.5
        self.imageView.frame = rect
        
        rect.size.height = 30
        rect.size.width = self.view.frame.size.width*0.75
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.view.frame.size.height*0.5 - rect.size.height*0.5
        self.titleLabel.frame = rect
        
        rect.size.height = 40
        rect.size.width =  self.view.frame.size.width*0.75
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height*0.5 + 10
        self.descriptionLabel.frame = rect
        
        rect.size.height = 40
        rect.size.width =  self.view.frame.size.width*0.75
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height*0.5 + 50
        self.button.frame = rect
    }
}
