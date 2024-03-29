//
//  UINavigationController+StatusBar.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/9/10.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        self.topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
