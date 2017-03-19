//
//  UIColor+Extension.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 19/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import UIKit

extension UIColor {
    static let customGreen = UIColor.colorWith(red: 69, green: 184, blue: 104, alpha: 0.30)
    
    private static func colorWith(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
