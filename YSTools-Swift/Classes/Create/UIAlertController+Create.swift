//
//  UIAlertController+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIAlertControllerCreateProtocol

public protocol UIAlertControllerCreateProtocol {}

public extension UIAlertControllerCreateProtocol where Self: UIAlertController {
    @discardableResult
    func ys_addAction(_ action: UIAlertAction) -> Self {
        self.addAction(action)
        return self
    }

    @discardableResult
    func ys_addAction(title: String?, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        self.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }

    @discardableResult
    func ys_addTextField(_ configurationHandler: ((UITextField) -> Void)? = nil) -> Self {
        self.addTextField(configurationHandler: configurationHandler)
        return self
    }

    @discardableResult
    func ys_preferredAction(_ action: UIAlertAction?) -> Self {
        self.preferredAction = action
        return self
    }

    @discardableResult
    func ys_title(_ title: String?) -> Self {
        self.title = title
        return self
    }

    @discardableResult
    func ys_message(_ message: String?) -> Self {
        self.message = message
        return self
    }

    @discardableResult
    func ys_present(from presenter: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> Self {
        presenter.present(self, animated: animated, completion: completion)
        return self
    }
}

extension UIAlertController: UIAlertControllerCreateProtocol {}
