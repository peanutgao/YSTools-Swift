//
//  UICollectionView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/24.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewCreateProtocol

public protocol UICollectionViewCreateProtocol {}

public extension UICollectionViewCreateProtocol where Self: UICollectionView {
    @discardableResult
    func ys_delegate(_ delegate: UICollectionViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func ys_dataSource(_ dataSource: UICollectionViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }

    @discardableResult
    func ys_register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) -> Self {
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func ys_register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) -> Self {
        self.register(nib, forCellWithReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func ys_register(
        _ viewClass: AnyClass?,
        forSupplementaryViewOfKind elementKind: String,
        withReuseIdentifier identifier: String
    ) -> Self {
        self.register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func ys_register(_ nib: UINib?, forSupplementaryViewOfKind kind: String,
                     withReuseIdentifier identifier: String) -> Self
    {
        self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        return self
    }

    @discardableResult
    func ys_collectionViewLayout(_ layout: UICollectionViewLayout) -> Self {
        self.collectionViewLayout = layout
        return self
    }

    @discardableResult
    func ys_setCollectionViewLayout(_ layout: UICollectionViewLayout, animated: Bool) -> Self {
        self.setCollectionViewLayout(layout, animated: animated)
        return self
    }

    @discardableResult
    func ys_isPagingEnabled(_ b: Bool) -> Self {
        self.isPagingEnabled = b
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
    func ys_backgroundView(_ view: UIView?) -> Self {
        self.backgroundView = view
        return self
    }

    @discardableResult
    func ys_contentInset(_ inset: UIEdgeInsets) -> Self {
        self.contentInset = inset
        return self
    }

    @discardableResult
    func ys_keyboardDismissMode(_ mode: UIScrollView.KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = mode
        return self
    }

    @discardableResult
    func ys_prefetchDataSource(_ dataSource: UICollectionViewDataSourcePrefetching?) -> Self {
        self.prefetchDataSource = dataSource
        return self
    }

    @discardableResult
    func ys_isPrefetchingEnabled(_ b: Bool) -> Self {
        self.isPrefetchingEnabled = b
        return self
    }

    @discardableResult
    func ys_showsVerticalScrollIndicator(_ b: Bool) -> Self {
        self.showsVerticalScrollIndicator = b
        return self
    }

    @discardableResult
    func ys_showsHorizontalScrollIndicator(_ b: Bool) -> Self {
        self.showsHorizontalScrollIndicator = b
        return self
    }
}

// MARK: - UICollectionView + UICollectionViewCreateProtocol

extension UICollectionView: UICollectionViewCreateProtocol {}
