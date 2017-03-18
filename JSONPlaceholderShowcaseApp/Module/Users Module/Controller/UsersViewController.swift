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

class UsersViewController: UIViewController, Alertable, OrderUserListDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var vcTitle: String!
    var usersArray: [User] = []
    let optionsView = EditOptionsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if vcTitle != nil {
            title = vcTitle
        }
        
        APIService.sharedInstance.loadData(withSuccess: { (users) in
            self.usersArray = users.sorted(by: { $0.name.compare($1.name) == .orderedAscending })
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        setUpNavBarButton()
    }

    func setUpNavBarButton() {
        let optionsBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleOptions))
        navigationItem.rightBarButtonItem = optionsBarButtonItem
    }
    
    func handleOptions() {
        optionsView.showOptions()
        optionsView.delegate = self
    }
    
    func orderUserNamesBy(order: Order) {
        if order == .Ascending {
            usersArray = usersArray.sorted(by: { $0.name.compare($1.name) == .orderedAscending })
        } else {
            usersArray = usersArray.sorted(by: { $0.name.compare($1.name) == .orderedDescending })
        }
        tableView.reloadData()
    }
    
}

extension UsersViewController: UITableViewDataSource {
    
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
    
}
