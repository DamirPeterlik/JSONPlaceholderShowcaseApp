//
//  UserTableViewCell.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 18/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCellWith(user: User) {
        userNameLabel.text = user.name
    }
    
}
