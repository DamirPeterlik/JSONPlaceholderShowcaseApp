//
//  UsersSectionHeaderView.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 26/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

class UsersSectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var labelTitle: UILabel!

    @IBAction func sectionButtonTouched() {
        print("section title touched")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init coder header view")
    }

    func setUpSectionDetails(string: String) {
        labelTitle.text = string
    }
    
}
