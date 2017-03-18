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

        APIService.sharedInstance.loadData(withSuccess: { (response) in
            self.showAlertWithMessage(message: "Data loaded")
            print(response)
        }) { (error) in
            print(error)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(Date())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print(Date())
            APIService.sharedInstance.postData(newPost: ["title": "Frist Psot", "body": "I iz fisrt", "userId": 1] as Dictionary<String, Any>, withSuccess: { (response) in
                print(response)
            }) { (error) in
                print(error)
            }
        }
        
        
    }
    
}

