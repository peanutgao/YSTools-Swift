//
//  UISearchBar+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UISearchBarCreateProtocol

public protocol UISearchBarCreateProtocol {}

public extension UISearchBarCreateProtocol where Self: UISearchBar {
    @discardableResult
    func ys_text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func ys_placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }

    @discardableResult
    func ys_prompt(_ prompt: String?) -> Self {
        self.prompt = prompt
        return self
    }

    @discardableResult
    func ys_searchBarStyle(_ style: UISearchBar.Style) -> Self {
        self.searchBarStyle = style
        return self
    }

    @discardableResult
    func ys_barStyle(_ style: UIBarStyle) -> Self {
        self.barStyle = style
        return self
    }

    @discardableResult
    func ys_barTintColor(_ color: UIColor?) -> Self {
        self.barTintColor = color
        return self
    }

    @discardableResult
    func ys_isTranslucent(_ b: Bool) -> Self {
        self.isTranslucent = b
        return self
    }

    @discardableResult
    func ys_showsCancelButton(_ b: Bool) -> Self {
        self.showsCancelButton = b
        return self
    }

    @discardableResult
    func ys_setShowsCancelButton(_ b: Bool, animated: Bool) -> Self {
        self.setShowsCancelButton(b, animated: animated)
        return self
    }

    @discardableResult
    func ys_showsBookmarkButton(_ b: Bool) -> Self {
        self.showsBookmarkButton = b
        return self
    }

    @discardableResult
    func ys_showsSearchResultsButton(_ b: Bool) -> Self {
        self.showsSearchResultsButton = b
        return self
    }

    @discardableResult
    func ys_showsScopeBar(_ b: Bool) -> Self {
        self.showsScopeBar = b
        return self
    }

    @discardableResult
    func ys_scopeButtonTitles(_ titles: [String]?) -> Self {
        self.scopeButtonTitles = titles
        return self
    }

    @discardableResult
    func ys_selectedScopeButtonIndex(_ index: Int) -> Self {
        self.selectedScopeButtonIndex = index
        return self
    }

    @discardableResult
    func ys_delegate(_ delegate: UISearchBarDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func ys_keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }

    @discardableResult
    func ys_returnKeyType(_ type: UIReturnKeyType) -> Self {
        self.returnKeyType = type
        return self
    }

    @discardableResult
    func ys_autocapitalizationType(_ type: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = type
        return self
    }

    @discardableResult
    func ys_autocorrectionType(_ type: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = type
        return self
    }
}

extension UISearchBar: UISearchBarCreateProtocol {}
