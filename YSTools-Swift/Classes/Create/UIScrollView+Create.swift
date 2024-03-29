//
//  UIScrollView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/11.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIScrollViewCreateProtocol

public protocol UIScrollViewCreateProtocol {}

public extension UIScrollViewCreateProtocol where Self: UIScrollView {
    @discardableResult
    func ys_delegate(_ delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func ys_showsVerticalScrollIndicator(_ b: Bool) -> Self {
        self.showsVerticalScrollIndicator = b
        return self
    }

    @discardableResult
    func ys_showsHorizontalScrollIndicator(_ b: Bool) -> Self {
        showsHorizontalScrollIndicator = b
        return self
    }

    @discardableResult
    func ys_indicatorStyle(_ style: UIScrollView.IndicatorStyle) -> Self {
        self.indicatorStyle = style
        return self
    }

    @discardableResult
    func ys_bounces(_ b: Bool) -> Self {
        self.bounces = b
        return self
    }

    @discardableResult
    func ys_contentSize(_ size: CGSize) -> Self {
        self.contentSize = size
        return self
    }
}

// MARK: - UIScrollView + UIScrollViewCreateProtocol

extension UIScrollView: UIScrollViewCreateProtocol {}
