//
//  ViewController.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 17/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit
import Alamofire
import Unbox

class ViewController: UIViewController, Alertable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("magic 1")
        APIService.sharedInstance.loadData(withSuccess: { (response) in
//            print(response)
            print("magic 2")
            self.showAlertWithMessage(message: "Data loaded")
            
        }) { (error) in
//            print(error)
        }
        print("magic 3")
    }
    
}

