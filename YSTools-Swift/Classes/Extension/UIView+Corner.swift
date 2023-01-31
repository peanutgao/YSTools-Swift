//
//  UIView+Corner.swift
//  SCDoctor
//
//  Created by Joseph Koh on 2019/5/28.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult
    public func ys_roundCorners(corners: UIRectCorner, radius: CGFloat) -> Self {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return self
    }
}
