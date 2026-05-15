//
//  UIRefreshControl+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIRefreshControlCreateProtocol

public protocol UIRefreshControlCreateProtocol {}

public extension UIRefreshControlCreateProtocol where Self: UIRefreshControl {
    @discardableResult
    func ys_attributedTitle(_ title: NSAttributedString?) -> Self {
        self.attributedTitle = title
        return self
    }

    @discardableResult
    func ys_tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func ys_beginRefreshing() -> Self {
        self.beginRefreshing()
        return self
    }

    @discardableResult
    func ys_endRefreshing() -> Self {
        self.endRefreshing()
        return self
    }
}

extension UIRefreshControl: UIRefreshControlCreateProtocol {}
