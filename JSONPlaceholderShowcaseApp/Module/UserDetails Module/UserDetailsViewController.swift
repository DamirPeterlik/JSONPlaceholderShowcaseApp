//
//  UserDetailsViewController.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 13/04/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

//    var user: UserObjectMapper!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        print(user.name)
        print(user.address.geolocation)
        

    }
    
    func setUpUI() {
        if user.name != "" {
            title = user.name
        }
    }

}
