//
//  UIColor+Random.swift
//  SCDoctor
//
//  Created by Joseph Koh on 2019/5/24.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension UIColor {
    public private(set) class var random: UIColor {
        get {
            return UIColor(red: CGFloat.random(in: 0...1.0),
                           green: CGFloat.random(in: 0...1.0),
                           blue: CGFloat.random(in: 0...1.0),
                           alpha: 1.0)
        }
        set {}
    }
}
