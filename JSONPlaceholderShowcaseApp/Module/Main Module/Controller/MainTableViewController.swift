//
//  MainTableViewController.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 17/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

private enum RowIdentifier: Int {
    case Users
    case Comments
    case Posts
    case ToDo
}

import UIKit
import Alamofire
import Unbox

class MainTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        print(Date())
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            print(Date())
//            APIService.sharedInstance.postData(newPost: ["title": "Frist Psot", "body": "I iz fisrt", "userId": 1] as Dictionary<String, Any>, withSuccess: { (response) in
//                print(response)
//            }) { (error) in
//                print(error)
//            }
//        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

        guard let rowIdentifier = RowIdentifier(rawValue: indexPath.row) else {
            return
        }
        
        var viewControllerIdentifier = ""
        
        switch rowIdentifier {
        case .Users:
            viewControllerIdentifier = "UsersViewController"
            break
        case .Comments:
            break
        case .Posts:
            break
        case .ToDo:
            break
        }
        
        if viewControllerIdentifier != "" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: viewControllerIdentifier) as! UsersViewController
            vc.vcTitle = String(describing: rowIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


