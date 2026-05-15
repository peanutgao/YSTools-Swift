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

    @discardableResult
    func ys_contentOffset(_ offset: CGPoint) -> Self {
        self.contentOffset = offset
        return self
    }

    @discardableResult
    func ys_contentInset(_ inset: UIEdgeInsets) -> Self {
        self.contentInset = inset
        return self
    }

    @discardableResult
    func ys_alwaysBounceVertical(_ b: Bool) -> Self {
        self.alwaysBounceVertical = b
        return self
    }

    @discardableResult
    func ys_alwaysBounceHorizontal(_ b: Bool) -> Self {
        self.alwaysBounceHorizontal = b
        return self
    }

    @discardableResult
    func ys_isPagingEnabled(_ b: Bool) -> Self {
        self.isPagingEnabled = b
        return self
    }

    @discardableResult
    func ys_isScrollEnabled(_ b: Bool) -> Self {
        self.isScrollEnabled = b
        return self
    }

    @discardableResult
    func ys_decelerationRate(_ rate: UIScrollView.DecelerationRate) -> Self {
        self.decelerationRate = rate
        return self
    }

    @discardableResult
    func ys_scrollIndicatorInsets(_ insets: UIEdgeInsets) -> Self {
        self.verticalScrollIndicatorInsets = insets
        self.horizontalScrollIndicatorInsets = insets
        return self
    }

    @discardableResult
    func ys_scrollsToTop(_ b: Bool) -> Self {
        self.scrollsToTop = b
        return self
    }

    @discardableResult
    func ys_minimumZoomScale(_ scale: CGFloat) -> Self {
        if scale > 0 {
            self.minimumZoomScale = scale
            if maximumZoomScale < minimumZoomScale { maximumZoomScale = scale }
        }
        return self
    }

    @discardableResult
    func ys_maximumZoomScale(_ scale: CGFloat) -> Self {
        if scale > 0 {
            self.maximumZoomScale = scale
            if minimumZoomScale > maximumZoomScale { minimumZoomScale = scale }
        }
        return self
    }

    @discardableResult
    func ys_zoomScale(_ scale: CGFloat) -> Self {
        if scale > 0 {
            minimumZoomScale = min(minimumZoomScale, scale)
            maximumZoomScale = max(maximumZoomScale, scale)
            self.zoomScale = scale
        }
        return self
    }

    @discardableResult
    func ys_keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = mode
        return self
    }

    @discardableResult
    func ys_refreshControl(_ control: UIRefreshControl?) -> Self {
        self.refreshControl = control
        return self
    }

    @available(iOS 11.0, *)
    @discardableResult
    func ys_contentInsetAdjustmentBehavior(_ behavior: UIScrollView.ContentInsetAdjustmentBehavior) -> Self {
        self.contentInsetAdjustmentBehavior = behavior
        return self
    }
}

// MARK: - UIScrollView + UIScrollViewCreateProtocol

extension UIScrollView: UIScrollViewCreateProtocol {}
