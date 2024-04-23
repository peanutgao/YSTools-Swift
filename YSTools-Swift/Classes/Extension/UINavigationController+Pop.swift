//
//  UINavigationController+Pop.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/27.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UINavigationController {
    @discardableResult
    func popToViewController(type viewController: UIViewController.Type, animated _: Bool) -> [UIViewController]? {
        for vc in children {
            if vc.isKind(of: viewController) == true {
                return self.popToViewController(vc, animated: true)
            }
        }
        return nil
    }

    func removeViewControllers<T: UIViewController>(ofType _: T.Type) {
        let updatedViewControllers = self.viewControllers.filter { viewController in
            !(viewController is T)
        }
        self.setViewControllers(updatedViewControllers, animated: false)
    }
    
    public func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void)
    {
        pushViewController(viewController, animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    func popViewController(
        animated: Bool,
        completion: @escaping () -> Void)
    {
        popViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

}
