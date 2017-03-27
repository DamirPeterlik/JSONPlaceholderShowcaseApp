//
//  WebViewController.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 26/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.google.hr/")!
        let urlRequest = URLRequest(url: url)
        
        webView.loadRequest(urlRequest)
        
    }

    deinit {
        print("WVC Memory to be released soon")
    }
    
}
