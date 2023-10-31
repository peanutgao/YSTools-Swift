//
//  UIViewController+Top.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/6.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Get ViewController in top present level
    public var topPresentedViewController: UIViewController? {
        var target: UIViewController? = self
        while (target?.presentedViewController != nil) {
            target = target?.presentedViewController
        }
        return target
    }
    
    // Get top VisibleViewController from ViewController stack in same present level.
    // It should be visibleViewController if self is a UINavigationController instance
    // It should be selectedViewController if self is a UITabBarController instance
    public var topVisibleViewController: UIViewController? {
        if let navigation = self as? UINavigationController {
            if let visibleViewController = navigation.visibleViewController {
                return visibleViewController.topVisibleViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selectedViewController = tab.selectedViewController {
                return selectedViewController.topVisibleViewController
            }
        }
        return self
    }
    
    // Combine both topPresentedViewController and topVisibleViewController methods, to get top visible viewcontroller in top present level
    public var topMostViewController: UIViewController? {
        return self.topPresentedViewController?.topVisibleViewController
    }
}
