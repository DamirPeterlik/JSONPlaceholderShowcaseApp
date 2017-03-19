//
//  BaseViewController.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 19/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }

}
