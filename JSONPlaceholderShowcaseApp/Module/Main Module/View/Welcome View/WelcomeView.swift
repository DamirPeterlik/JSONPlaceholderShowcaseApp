//
//  WelcomeView.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 19/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    @IBOutlet var customView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "WelcomeView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
    }

    func showWelcomeView() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(customView)
            
            customView.frame = window.frame
            customView.alpha = 0
            customView.backgroundColor = UIColor.customGreen
            
            customView.autoSetDimension(.height, toSize: 200)
            customView.autoSetDimension(.width, toSize: 250)
            customView.autoCenterInSuperview()

            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear, animations: {
                self.customView.alpha = 1
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear, animations: {
                    self.customView.alpha = 0
                }, completion:nil)
            })
        }
    }
    
}
