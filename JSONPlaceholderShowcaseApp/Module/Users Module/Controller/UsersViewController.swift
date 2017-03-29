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
    
    deinit {
        print("UVC Memory to be released soon")
    }
    
    func loadUsersFromAPI() {
        APIService.sharedInstance.loadUsers(withSuccess: { (users) in
            self.usersArray = users.sorted(by: { $0.name.compare($1.name) == .orderedAscending })
            self.tableView.reloadData()
            self.setUpTable()
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
        let optionsBarButtonEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleOptions))
        let optionsBarButtonFilter = UIBarButtonItem(image: UIImage(named: "menuslider"), style: .done, target: self, action: #selector(handleFilterOptions))
        navigationItem.rightBarButtonItems = [optionsBarButtonEdit, optionsBarButtonFilter]
    }
    
    func handleFilterOptions() {
        print("filter touched")
    }
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        let nibSection = UINib(nibName: "UsersSectionHeaderView", bundle: nil)
        tableView.register(nibSection, forHeaderFooterViewReuseIdentifier: "UsersSectionHeaderView")
        let nibFooter = UINib(nibName: "UsersSectionFooterView", bundle: nil)
        tableView.register(nibFooter, forHeaderFooterViewReuseIdentifier: "UsersSectionFooterView")
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if usersArray.count > 0 {
            return 60
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if usersArray.count > 0 {
            let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "UsersSectionHeaderView") as! UsersSectionHeaderView
            cell.setUpSectionDetails(string: "Title of all titles")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if usersArray.count > 0 {
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if usersArray.count > 0 {
            let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "UsersSectionFooterView") as! UsersSectionFooterView
            cell.setUpFooterDetails(string: "Title of all titles")
            cell.rootVC = self
            
            return cell
        }
        return UITableViewCell()
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
