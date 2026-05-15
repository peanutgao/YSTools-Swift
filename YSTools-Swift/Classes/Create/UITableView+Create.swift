//
//  UITableView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/10.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UITableViewCreateProtocol

public protocol UITableViewCreateProtocol {}

public extension UITableViewCreateProtocol where Self: UITableView {
    @discardableResult
    func ys_dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }

    @discardableResult
    func ys_delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func ys_separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
        self.separatorStyle = style
        return self
    }

    @discardableResult
    func ys_contentInset(_ inset: UIEdgeInsets) -> Self {
        self.contentInset = inset
        return self
    }

    @discardableResult
    func ys_register(_ cellClass: AnyClass, forCellReuseIdentifier identifier: String) -> Self {
        self.register(cellClass, forCellReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func ys_sectionIndexColor(_ color: UIColor) -> Self {
        self.sectionIndexColor = color
        return self
    }

    @discardableResult
    func ys_sectionIndexBackgroundColor(_ color: UIColor) -> Self {
        self.sectionIndexBackgroundColor = color
        return self
    }

    @discardableResult
    func ys_sectionFooterHeight(_ height: CGFloat) -> Self {
        self.sectionFooterHeight = height
        return self
    }

    @discardableResult
    func ys_rowHeight(_ rowHeight: CGFloat) -> Self {
        self.rowHeight = rowHeight
        return self
    }

    @discardableResult
    func ys_tableFooterView(_ view: UIView) -> Self {
        self.tableFooterView = view
        return self
    }

    @discardableResult
    func ys_tableHeaderView(_ view: UIView) -> Self {
        self.tableHeaderView = view
        return self
    }

    @discardableResult
    func ys_estimatedRowHeight(_ height: CGFloat) -> Self {
        self.estimatedRowHeight = height
        return self
    }

    @discardableResult
    func ys_estimatedSectionHeaderHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionHeaderHeight = height
        return self
    }

    @discardableResult
    func ys_keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = mode
        return self
    }

    @discardableResult
    func ys_register(_ nib: UINib?, forCellReuseIdentifier identifier: String) -> Self {
        self.register(nib, forCellReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func ys_register(_ aClass: AnyClass?, forHeaderFooterViewReuseIdentifier identifier: String) -> Self {
        self.register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func ys_register(_ nib: UINib?, forHeaderFooterViewReuseIdentifier identifier: String) -> Self {
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func ys_separatorColor(_ color: UIColor?) -> Self {
        self.separatorColor = color
        return self
    }

    @discardableResult
    func ys_separatorInset(_ inset: UIEdgeInsets) -> Self {
        self.separatorInset = inset
        return self
    }

    @discardableResult
    func ys_backgroundView(_ view: UIView?) -> Self {
        self.backgroundView = view
        return self
    }

    @discardableResult
    func ys_allowsSelection(_ b: Bool) -> Self {
        self.allowsSelection = b
        return self
    }

    @discardableResult
    func ys_allowsMultipleSelection(_ b: Bool) -> Self {
        self.allowsMultipleSelection = b
        return self
    }

    @discardableResult
    func ys_allowsSelectionDuringEditing(_ b: Bool) -> Self {
        self.allowsSelectionDuringEditing = b
        return self
    }

    @discardableResult
    func ys_isEditing(_ b: Bool) -> Self {
        self.isEditing = b
        return self
    }

    @discardableResult
    func ys_sectionHeaderHeight(_ height: CGFloat) -> Self {
        self.sectionHeaderHeight = height
        return self
    }

    @discardableResult
    func ys_estimatedSectionFooterHeight(_ height: CGFloat) -> Self {
        self.estimatedSectionFooterHeight = height
        return self
    }

    @available(iOS 15.0, *)
    @discardableResult
    func ys_sectionHeaderTopPadding(_ padding: CGFloat) -> Self {
        self.sectionHeaderTopPadding = padding
        return self
    }
}

// MARK: - UITableView + UITableViewCreateProtocol

extension UITableView: UITableViewCreateProtocol {}
