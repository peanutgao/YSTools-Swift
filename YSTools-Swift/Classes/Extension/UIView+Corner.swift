//
//  UIView+Corner.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/28.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult
    func roundCorners(corners: UIRectCorner, radius: CGFloat) -> Self {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        return self
    }

    @discardableResult
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) -> Self {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        return self
    }
}
