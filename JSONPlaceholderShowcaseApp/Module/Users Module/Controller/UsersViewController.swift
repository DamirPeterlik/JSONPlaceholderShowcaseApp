//
//  UsersViewController.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 18/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

enum Order: Int {
    case Ascending
    case Descending
}

protocol OrderUserListDelegate: class {
    func orderUserNamesBy(order: Order)
}

class UsersViewController: BaseViewController, Alertable, OrderUserListDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var vcTitle: String!
    var usersArray: [User] = []
    lazy var optionsView: EditOptionsView = {
        let options = EditOptionsView()
        return options
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersFromAPI()
        setUpUI()
    }
    
    func loadUsersFromAPI() {
        APIService.sharedInstance.loadUsers(withSuccess: { (users) in
            self.usersArray = users.sorted(by: { $0.name.compare($1.name) == .orderedAscending })
            self.tableView.reloadData()
            self.triggerNots()
        }) { (error) in
            print(error)
        }
    }
    
    func triggerNots() {
        let notName = Notification.Name.init(rawValue: "usersDownloaded")
        NotificationCenter.default.post(name: notName, object: self.usersArray[0])
    }
    
    func setUpUI() {
        if vcTitle != nil {
            title = vcTitle
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        let optionsBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleOptions))
        navigationItem.rightBarButtonItem = optionsBarButtonItem
    }
    
    func handleOptions() {
        optionsView.showOptions()
        optionsView.delegate = self
    }
    
    func orderUserNamesBy(order: Order) {
        
        NotificationManager.sharedManager.scheduleNotification(inSeconds: 1) { (success) in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        }
        
        if order == .Ascending {
            usersArray = usersArray.sorted(by: { $0.name.compare($1.name) == .orderedAscending })
        } else {
            usersArray = usersArray.sorted(by: { $0.name.compare($1.name) == .orderedDescending })
        }
        tableView.reloadData()
    }
    
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = usersArray[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell {
            cell.configureCellWith(user: user)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
