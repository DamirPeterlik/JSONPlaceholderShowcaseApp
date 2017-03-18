//
//  EditOptionsTableViewCell.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 18/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit
import PureLayout

class EditOptionsTableViewCell: UITableViewCell {
    
    var sortByNameLabel: UILabel = {
        let label = UILabel()
        label.text = "A-Z"
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configureCell() {
        self.selectionStyle = .none
        addSubview(sortByNameLabel)
        sortByNameLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 15)
        sortByNameLabel.autoPinEdge(.top, to: .top, of: self, withOffset: self.frame.height/4)
    }

}
