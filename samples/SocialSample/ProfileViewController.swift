//
//  ViewController.swift
//  SocialSample
//
//  Created by Julian Gruber on 12/12/2016.
//  Copyright © 2016 Quikkly Ltd. All rights reserved.
//

import UIKit
import Quikkly

class ProfileViewController: UIViewController {

    var backgroundView:UIView!
    var scannableView:ScannableView!
    var titleLabel:UILabel!
    var descriptionLabel:UILabel!
    var loggedInLabel:UILabel!
    var loggedInSegmentedControl:UISegmentedControl!
    var addButton:UIButton!
    private var user:User!
    
    init(withUser user:User) {
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
        
        self.title = "User"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.backgroundView = UIView(frame: CGRect())
        self.backgroundView.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.2, alpha: 1.0)
        self.view.addSubview(self.backgroundView)
        
        self.scannableView = ScannableView(frame: CGRect())
        self.backgroundView.addSubview(self.scannableView)
        
        self.titleLabel = UILabel(frame: CGRect())
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(self.titleLabel)
        
        self.descriptionLabel = UILabel(frame: CGRect())
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        self.descriptionLabel.textColor = .gray
        self.view.addSubview(self.descriptionLabel)
        
        self.loggedInLabel = UILabel(frame: CGRect())
        self.loggedInLabel.textAlignment = .center
        self.loggedInLabel.font = UIFont.systemFont(ofSize: 15)
        self.loggedInLabel.textColor = .gray
        self.view.addSubview(self.loggedInLabel)
        
        self.loggedInSegmentedControl = UISegmentedControl(items: nil)
        self.view.addSubview(self.loggedInSegmentedControl)
        
        self.addButton = UIButton(type: .contactAdd)
        self.addButton.setTitle(" Add to friends list", for: .normal)
        self.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        self.view.addSubview(self.addButton)
    }
    
    @IBAction func addButtonTapped() {
        let vc = UIAlertController(title: "Button Tapped", message: "This is where an event could be handled", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            vc.dismiss(animated: true, completion: nil)
        }))
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.load()
    }
    
    func load() {
        guard let user = self.user, let id = user.id else {
            return
        }
        let skin = ScannableSkin()
        skin.backgroundColor = "#3299FF"
        skin.codeColor = "#FFFFFF"
        skin.borderColor = "#FFFFFF"
        skin.imageUri = user.profilePic
        skin.imageWidth = 225
        skin.imageHeight = 225
        let scannable = Scannable(withValue: NSNumber(value: id), skin: skin)
        self.scannableView.scannable = scannable
        
        self.titleLabel.text = user.name
        self.descriptionLabel.text = user.dob
        self.loggedInLabel.text = "Logged in with"
        
        
        if let storedUsers = User.stored {
            self.loggedInSegmentedControl.removeTarget(self, action: nil, for: .valueChanged)
            self.loggedInSegmentedControl.removeAllSegments()
            for user in storedUsers {
                self.loggedInSegmentedControl.insertSegment(withTitle: user.name, at: self.loggedInSegmentedControl.numberOfSegments, animated: false)
                if user.id == User.loggedInId {
                    self.loggedInSegmentedControl.selectedSegmentIndex = self.loggedInSegmentedControl.numberOfSegments - 1
                }
            }
            self.loggedInSegmentedControl.addTarget(self, action: #selector(loginValueChanged), for: .valueChanged)
        }
        
        var showsAddButton = false
        if User.loggedInId == self.user.id {
            self.title = "Me"
        } else {
            showsAddButton = true
        }
        
        self.loggedInLabel.isHidden = showsAddButton
        self.loggedInLabel.isEnabled = !showsAddButton
        self.loggedInSegmentedControl.isHidden = showsAddButton
        self.loggedInSegmentedControl.isEnabled = !showsAddButton
        self.addButton.isHidden = !showsAddButton
        self.addButton.isEnabled = showsAddButton
    }
    
    func loginValueChanged() {
        if let storedUsers = User.stored, self.loggedInSegmentedControl.selectedSegmentIndex < storedUsers.count {
            let newLoggedInUser = storedUsers[self.loggedInSegmentedControl.selectedSegmentIndex]
            if let newId = newLoggedInUser.id {
                User.loggedInId = newId
                self.user = newLoggedInUser
                self.load()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect()
        
        rect.size.width = self.view.frame.size.width
        rect.size.height = self.view.frame.size.height*0.4
        rect.origin.x = 0
        rect.origin.y = 0
        if let nav = self.navigationController {
            rect.origin.y = UIApplication.shared.statusBarFrame.size.height + nav.navigationBar.frame.size.height
        }
        self.backgroundView.frame = rect
        
        rect.size.width = self.backgroundView.frame.size.width
        rect.size.height = self.backgroundView.frame.size.height*0.7
        rect.origin.x = self.backgroundView.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.backgroundView.frame.size.height*0.5 - rect.size.height*0.5
        self.scannableView.frame = rect
        
        rect.size.width = self.view.frame.size.width
        rect.size.height = 45
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.backgroundView.frame.origin.y + self.backgroundView.frame.size.height + 25
        self.titleLabel.frame = rect
        
        rect.size.width = self.view.frame.size.width
        rect.size.height = 45
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10
        self.descriptionLabel.frame = rect
        
        rect.size.width = self.loggedInSegmentedControl.frame.size.width
        rect.size.height = 40
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.view.frame.size.height*0.9 - rect.size.height*0.5
        self.loggedInSegmentedControl.frame = rect
        
        rect.size.width = self.view.frame.size.width
        rect.size.height = 30
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.loggedInSegmentedControl.frame.origin.y - rect.size.height - 5
        self.loggedInLabel.frame = rect
        
        rect.size.width = self.view.frame.size.width
        rect.size.height = 45
        rect.origin.x = self.view.frame.size.width*0.5 - rect.size.width*0.5
        rect.origin.y = self.view.frame.size.height*0.85 - rect.size.height*0.5
        self.addButton.frame = rect
    }

}

