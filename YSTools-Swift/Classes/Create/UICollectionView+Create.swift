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
}

// MARK: - UICollectionView + UICollectionViewCreateProtocol

extension UICollectionView: UICollectionViewCreateProtocol {}
