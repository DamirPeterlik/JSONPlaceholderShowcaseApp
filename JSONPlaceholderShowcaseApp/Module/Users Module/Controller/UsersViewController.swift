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
    var sectionUserLetters: [String] = []
    var contacts = [String : [User]]()
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
        
//        APIService.sharedInstance.loadUsersObjectMapper(withSuccess: { (users) in
//            print(users)
//        }) { (error) in
//            print(error)
//        }
        
        APIService.sharedInstance.loadUsers(withSuccess: { (users) in
            self.usersArray = users.sorted(by: { $0.name.compare($1.name) == .orderedAscending })
            self.setUpTable()
            self.triggerNots()
            self.tableView.reloadData()
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
        
        let (letters, contactUsers) = sectionUserLetters.getFirstCharactersFromUsersToLetterArrayAndLetterUserDict(namesArray: usersArray)
        
        sectionUserLetters = letters
        contacts = contactUsers
        
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
        self.setUpTable()
        tableView.reloadData()
    }
    
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionUserLetters.first != nil {
            return sectionUserLetters.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contacts.count > 0 {
            return (contacts[sectionUserLetters[section]]?.count)!
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if contacts.count > 0 {
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if usersArray.count > 0 {
            let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "UsersSectionHeaderView") as! UsersSectionHeaderView
            cell.setUpSectionDetails(string: sectionUserLetters[section])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if contacts.count > 0 {
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if usersArray.count > 0 {
            let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "UsersSectionFooterView") as! UsersSectionFooterView
            cell.setUpFooterDetails(string: "Footer Title")
            cell.rootVC = self
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if contacts.count > 0 {
            let contact = contacts[sectionUserLetters[indexPath.section]]
            let user = contact?[indexPath.row]
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell {
                cell.configureCellWith(user: user!)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "UserDetailsStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        
        let contact = contacts[sectionUserLetters[indexPath.section]]
        vc.user = contact?[indexPath.row]
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: vcTitle, style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
