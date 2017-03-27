//
//  UsersSectionFooterView.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 26/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

class UsersSectionFooterView: UITableViewHeaderFooterView {

    weak var rootVC: UIViewController?
    
    @IBAction func openURLwithSafariButtonTouched() {
        let url = URL(string: "https://www.google.hr/")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func openURLwithWebviewButtonTouched() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        rootVC!.navigationController?.pushViewController(vc, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init coder footer view")
    }
    
    func setUpFooterDetails(string: String) {
        
    }
    
    deinit {
        print("FV Memory to be released soon")
    }

}
