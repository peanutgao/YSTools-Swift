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
    public func popToViewController(_ viewController: UIViewController.Type, animated: Bool) -> [UIViewController]? {
        for vc in self.children {
            if vc.isKind(of: viewController) == true {
                return self.popToViewController(vc, animated: true)
            }
        }
        
        return nil
    }
}
