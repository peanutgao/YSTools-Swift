//
//  UINavigationController+Pop.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/27.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension UINavigationController {
    @discardableResult
    public func popToViewController(_ viewController: UIViewController.Type, animated _: Bool) -> [UIViewController]? {
        for vc in children {
            if vc.isKind(of: viewController) == true {
                return self.popToViewController(vc, animated: true)
            }
        }
        return nil
    }

    public func removeViewControllers<T: UIViewController>(ofType _: T.Type) {
        let updatedViewControllers = self.viewControllers.filter { viewController in
            !(viewController is T)
        }
        self.setViewControllers(updatedViewControllers, animated: false)
    }
}
