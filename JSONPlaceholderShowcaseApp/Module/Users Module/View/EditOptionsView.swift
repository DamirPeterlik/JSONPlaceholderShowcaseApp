//
//  EditOptionsView.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 18/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

class EditOptionsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let blackTransView = UIView()
    let cellId = "editOptionsTableViewCell"
    let tableView: UITableView = {
        let layout = UITableView(frame: .zero)
        return layout
    }()
    
    weak var delegate: OrderUserListDelegate?
    
    func showOptions() {
        if let window = UIApplication.shared.keyWindow {
            blackTransView.backgroundColor = UIColor(white: 0, alpha: 0.6)
            blackTransView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackTransView)
            window.addSubview(tableView)

            let height: CGFloat = 200
            let y = window.frame.height - height
            tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackTransView.frame = window.frame
            blackTransView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackTransView.alpha = 1
                self.tableView.frame = CGRect(x: 0, y: y, width: self.tableView.frame.width, height: self.tableView.frame.height)
            }, completion: nil)
        }
    }
    
    func handleDismiss() {
        let window = UIApplication.shared.keyWindow

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackTransView.alpha = 0
            self.tableView.frame = CGRect(x: 0, y: (window?.frame.height)!, width: self.tableView.frame.width, height: self.tableView.frame.height)
        }, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(EditOptionsTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? EditOptionsTableViewCell {
            cell.configureCell()
            if indexPath.row == 0 {
                cell.sortByNameLabel.text = "A-Z"
            } else {
                cell.sortByNameLabel.text = "Z-A"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var order: Order = .Ascending
        if indexPath.row == 1 {
            order = .Descending
        }
        delegate?.orderUserNamesBy(order: order)
        handleDismiss()
    }
    
}




