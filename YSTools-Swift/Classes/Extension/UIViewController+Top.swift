//
//  UIViewController+Top.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/6.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// Get ViewController in top present level
    var topPresentedViewController: UIViewController? {
        var target: UIViewController? = self
        while target?.presentedViewController != nil {
            target = target?.presentedViewController
        }
        return target
    }

    /// Get top VisibleViewController from ViewController stack in same present level.
    /// It should be visibleViewController if self is a UINavigationController instance
    /// It should be selectedViewController if self is a UITabBarController instance
    var topVisibleViewController: UIViewController? {
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topVisibleViewController
        }
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topVisibleViewController
        }
        if let split = self as? UISplitViewController {
            return split.viewControllers.last?.topVisibleViewController
        }
        return self
    }

    /// Combine both topPresentedViewController and topVisibleViewController methods, to get top visible viewcontroller in top present level
    var topMostViewController: UIViewController? {
        topPresentedViewController?.topVisibleViewController
    }

    static var topMostViewController: UIViewController? {
        guard let rootViewController = UIApplication.shared.windows.filter(\.isKeyWindow).first?.rootViewController else {
            return nil
        }
        return rootViewController.topMostViewController
    }
}
