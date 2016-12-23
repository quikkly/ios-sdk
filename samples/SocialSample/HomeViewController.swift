//
//  HomeViewController.swift
//  Samples
//
//  Created by Julian Gruber on 12/12/2016.
//  Copyright © 2016 Quikkly Ltd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let inset:CGFloat = 15
    let spacing:CGFloat = 10
    let reuseIdentifier = "Sample.HomeReuseIdentifier"
    let titles = ["Dolores Hoffman", "Irene Stokes", "Willie Park", "Nicholas Payne", "Arturo Martin", "Joshua Ramos", "Tanya Flores", "Jack Goodman", "Jermaine Porter", "Connie Henry"]
    
    var tableView:UITableView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Friends"
        
        let itemUser = UIBarButtonItem(image: UIImage(named: "BarButtonImage-User"), style: .plain, target: self, action: #selector(userButtonTapped))
        self.navigationItem.leftBarButtonItem = itemUser
        let itemAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = itemAdd
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect(), style: .plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.contentInset = UIEdgeInsetsMake(spacing, 0, 0, 0)
        self.view.addSubview(self.tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //self.tableView.reloadData()
        self.tableView.contentOffset = CGPoint(x: 0, y: -(22+44+spacing))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var rect = CGRect()
        rect.origin.x = inset
        rect.origin.y = 0
        rect.size.width = self.view.frame.size.width - 2*inset
        rect.size.height = self.view.frame.size.height
        self.tableView.frame = rect
    }
    
    @IBAction
    func userButtonTapped() {
        guard let u = User.storedUser(withId: User.loggedInId) else {
            return
        }
        
        let vc = ProfileViewController(withUser: u)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction
    func addButtonTapped() {
        let vc = CustomScanViewController()
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 != 0 {
            return spacing
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        let vc = UIAlertController(title: "Table View Cell Tapped", message: "This is where the event could be handled", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            vc.dismiss(animated: true, completion: nil)
        }))
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count*2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if indexPath.row % 2 != 0 {
            cell.textLabel?.text = nil
            cell.layer.cornerRadius = 0
            cell.backgroundColor = .clear
            cell.accessoryType = .none
            return cell
        }
        
        let row = indexPath.row/2
        if row < self.titles.count {
            cell.textLabel?.text = self.titles[row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.layer.cornerRadius = 15
            cell.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.selectionStyle = .none
        
        return cell
    }

}
