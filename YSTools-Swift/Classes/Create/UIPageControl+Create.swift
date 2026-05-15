//
//  UIPageControl+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIPageControlCreateProtocol

public protocol UIPageControlCreateProtocol {}

public extension UIPageControlCreateProtocol where Self: UIPageControl {
    @discardableResult
    func ys_numberOfPages(_ count: Int) -> Self {
        self.numberOfPages = count
        return self
    }

    @discardableResult
    func ys_currentPage(_ page: Int) -> Self {
        self.currentPage = page
        return self
    }

    @discardableResult
    func ys_hidesForSinglePage(_ b: Bool) -> Self {
        self.hidesForSinglePage = b
        return self
    }

    @discardableResult
    func ys_pageIndicatorTintColor(_ color: UIColor?) -> Self {
        self.pageIndicatorTintColor = color
        return self
    }

    @discardableResult
    func ys_currentPageIndicatorTintColor(_ color: UIColor?) -> Self {
        self.currentPageIndicatorTintColor = color
        return self
    }

    @available(iOS 14.0, *)
    @discardableResult
    func ys_backgroundStyle(_ style: UIPageControl.BackgroundStyle) -> Self {
        self.backgroundStyle = style
        return self
    }

    @available(iOS 14.0, *)
    @discardableResult
    func ys_allowsContinuousInteraction(_ b: Bool) -> Self {
        self.allowsContinuousInteraction = b
        return self
    }

    @available(iOS 14.0, *)
    @discardableResult
    func ys_preferredIndicatorImage(_ image: UIImage?) -> Self {
        self.preferredIndicatorImage = image
        return self
    }
}

extension UIPageControl: UIPageControlCreateProtocol {}
