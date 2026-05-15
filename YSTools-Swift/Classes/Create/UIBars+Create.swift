//
//  UIBars+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UINavigationBar

public protocol UINavigationBarCreateProtocol {}

public extension UINavigationBarCreateProtocol where Self: UINavigationBar {
    @discardableResult
    func ys_barTintColor(_ color: UIColor?) -> Self {
        self.barTintColor = color
        return self
    }

    @discardableResult
    func ys_tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func ys_isTranslucent(_ b: Bool) -> Self {
        self.isTranslucent = b
        return self
    }

    @discardableResult
    func ys_titleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?) -> Self {
        self.titleTextAttributes = attributes
        return self
    }

    @discardableResult
    func ys_setBackgroundImage(_ image: UIImage?, for barMetrics: UIBarMetrics) -> Self {
        self.setBackgroundImage(image, for: barMetrics)
        return self
    }

    @discardableResult
    func ys_shadowImage(_ image: UIImage?) -> Self {
        self.shadowImage = image
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult
    func ys_standardAppearance(_ appearance: UINavigationBarAppearance) -> Self {
        self.standardAppearance = appearance
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult
    func ys_scrollEdgeAppearance(_ appearance: UINavigationBarAppearance?) -> Self {
        self.scrollEdgeAppearance = appearance
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult
    func ys_compactAppearance(_ appearance: UINavigationBarAppearance?) -> Self {
        self.compactAppearance = appearance
        return self
    }
}

extension UINavigationBar: UINavigationBarCreateProtocol {}

// MARK: - UITabBar

public protocol UITabBarCreateProtocol {}

public extension UITabBarCreateProtocol where Self: UITabBar {
    @discardableResult
    func ys_barTintColor(_ color: UIColor?) -> Self {
        self.barTintColor = color
        return self
    }

    @discardableResult
    func ys_tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func ys_unselectedItemTintColor(_ color: UIColor?) -> Self {
        self.unselectedItemTintColor = color
        return self
    }

    @discardableResult
    func ys_isTranslucent(_ b: Bool) -> Self {
        self.isTranslucent = b
        return self
    }

    @discardableResult
    func ys_backgroundImage(_ image: UIImage?) -> Self {
        self.backgroundImage = image
        return self
    }

    @discardableResult
    func ys_shadowImage(_ image: UIImage?) -> Self {
        self.shadowImage = image
        return self
    }

    @discardableResult
    func ys_selectionIndicatorImage(_ image: UIImage?) -> Self {
        self.selectionIndicatorImage = image
        return self
    }

    @discardableResult
    func ys_itemPositioning(_ positioning: UITabBar.ItemPositioning) -> Self {
        self.itemPositioning = positioning
        return self
    }

    @discardableResult
    func ys_itemSpacing(_ spacing: CGFloat) -> Self {
        self.itemSpacing = spacing
        return self
    }

    @discardableResult
    func ys_itemWidth(_ width: CGFloat) -> Self {
        self.itemWidth = width
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult
    func ys_standardAppearance(_ appearance: UITabBarAppearance) -> Self {
        self.standardAppearance = appearance
        return self
    }

    @available(iOS 15.0, *)
    @discardableResult
    func ys_scrollEdgeAppearance(_ appearance: UITabBarAppearance?) -> Self {
        self.scrollEdgeAppearance = appearance
        return self
    }
}

extension UITabBar: UITabBarCreateProtocol {}

// MARK: - UIToolbar

public protocol UIToolbarCreateProtocol {}

public extension UIToolbarCreateProtocol where Self: UIToolbar {
    @discardableResult
    func ys_barTintColor(_ color: UIColor?) -> Self {
        self.barTintColor = color
        return self
    }

    @discardableResult
    func ys_tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func ys_isTranslucent(_ b: Bool) -> Self {
        self.isTranslucent = b
        return self
    }

    @discardableResult
    func ys_barStyle(_ style: UIBarStyle) -> Self {
        self.barStyle = style
        return self
    }

    @discardableResult
    func ys_setItems(_ items: [UIBarButtonItem]?, animated: Bool) -> Self {
        self.setItems(items, animated: animated)
        return self
    }

    @discardableResult
    func ys_setBackgroundImage(_ image: UIImage?, forToolbarPosition position: UIBarPosition, barMetrics: UIBarMetrics) -> Self {
        self.setBackgroundImage(image, forToolbarPosition: position, barMetrics: barMetrics)
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult
    func ys_standardAppearance(_ appearance: UIToolbarAppearance) -> Self {
        self.standardAppearance = appearance
        return self
    }
}

extension UIToolbar: UIToolbarCreateProtocol {}
