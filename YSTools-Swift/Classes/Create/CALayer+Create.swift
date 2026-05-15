//
//  CALayer+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import QuartzCore
import UIKit

// MARK: - CALayerCreateProtocol

public protocol CALayerCreateProtocol {}

public extension CALayerCreateProtocol where Self: CALayer {
    @discardableResult
    func ys_frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    func ys_bounds(_ bounds: CGRect) -> Self {
        self.bounds = bounds
        return self
    }

    @discardableResult
    func ys_position(_ position: CGPoint) -> Self {
        self.position = position
        return self
    }

    @discardableResult
    func ys_anchorPoint(_ point: CGPoint) -> Self {
        self.anchorPoint = point
        return self
    }

    @discardableResult
    func ys_backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color?.cgColor
        return self
    }

    @discardableResult
    func ys_cornerRadius(_ radius: CGFloat) -> Self {
        self.cornerRadius = radius
        return self
    }

    @discardableResult
    func ys_borderWidth(_ width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }

    @discardableResult
    func ys_borderColor(_ color: UIColor?) -> Self {
        self.borderColor = color?.cgColor
        return self
    }

    @discardableResult
    func ys_masksToBounds(_ b: Bool) -> Self {
        self.masksToBounds = b
        return self
    }

    @discardableResult
    func ys_opacity(_ opacity: Float) -> Self {
        self.opacity = opacity
        return self
    }

    @discardableResult
    func ys_isHidden(_ b: Bool) -> Self {
        self.isHidden = b
        return self
    }

    @discardableResult
    func ys_shadowColor(_ color: UIColor?) -> Self {
        self.shadowColor = color?.cgColor
        return self
    }

    @discardableResult
    func ys_shadowOffset(_ offset: CGSize) -> Self {
        self.shadowOffset = offset
        return self
    }

    @discardableResult
    func ys_shadowRadius(_ radius: CGFloat) -> Self {
        self.shadowRadius = radius
        return self
    }

    @discardableResult
    func ys_shadowOpacity(_ opacity: Float) -> Self {
        self.shadowOpacity = opacity
        return self
    }

    @discardableResult
    func ys_shadowPath(_ path: CGPath?) -> Self {
        self.shadowPath = path
        return self
    }

    @discardableResult
    func ys_addSublayer(_ layer: CALayer) -> Self {
        self.addSublayer(layer)
        return self
    }

    @discardableResult
    func ys_mask(_ mask: CALayer?) -> Self {
        self.mask = mask
        return self
    }

    @discardableResult
    func ys_transform(_ transform: CATransform3D) -> Self {
        self.transform = transform
        return self
    }

    @discardableResult
    func ys_contents(_ contents: Any?) -> Self {
        self.contents = contents
        return self
    }

    @discardableResult
    func ys_contentsScale(_ scale: CGFloat) -> Self {
        self.contentsScale = scale
        return self
    }

    @discardableResult
    func ys_maskedCorners(_ corners: CACornerMask) -> Self {
        self.maskedCorners = corners
        return self
    }
}

extension CALayer: CALayerCreateProtocol {}

// MARK: - CAGradientLayer

public extension CAGradientLayer {
    @discardableResult
    func ys_colors(_ colors: [UIColor]) -> Self {
        self.colors = colors.map { $0.cgColor }
        return self
    }

    @discardableResult
    func ys_locations(_ locations: [NSNumber]?) -> Self {
        self.locations = locations
        return self
    }

    @discardableResult
    func ys_startPoint(_ point: CGPoint) -> Self {
        self.startPoint = point
        return self
    }

    @discardableResult
    func ys_endPoint(_ point: CGPoint) -> Self {
        self.endPoint = point
        return self
    }

    @discardableResult
    func ys_type(_ type: CAGradientLayerType) -> Self {
        self.type = type
        return self
    }
}

// MARK: - CAShapeLayer

public extension CAShapeLayer {
    @discardableResult
    func ys_path(_ path: CGPath?) -> Self {
        self.path = path
        return self
    }

    @discardableResult
    func ys_fillColor(_ color: UIColor?) -> Self {
        self.fillColor = color?.cgColor
        return self
    }

    @discardableResult
    func ys_strokeColor(_ color: UIColor?) -> Self {
        self.strokeColor = color?.cgColor
        return self
    }

    @discardableResult
    func ys_lineWidth(_ width: CGFloat) -> Self {
        self.lineWidth = width
        return self
    }

    @discardableResult
    func ys_lineCap(_ cap: CAShapeLayerLineCap) -> Self {
        self.lineCap = cap
        return self
    }

    @discardableResult
    func ys_lineJoin(_ join: CAShapeLayerLineJoin) -> Self {
        self.lineJoin = join
        return self
    }

    @discardableResult
    func ys_lineDashPattern(_ pattern: [NSNumber]?) -> Self {
        self.lineDashPattern = pattern
        return self
    }

    @discardableResult
    func ys_lineDashPhase(_ phase: CGFloat) -> Self {
        self.lineDashPhase = phase
        return self
    }

    @discardableResult
    func ys_strokeStart(_ value: CGFloat) -> Self {
        self.strokeStart = value
        return self
    }

    @discardableResult
    func ys_strokeEnd(_ value: CGFloat) -> Self {
        self.strokeEnd = value
        return self
    }

    @discardableResult
    func ys_fillRule(_ rule: CAShapeLayerFillRule) -> Self {
        self.fillRule = rule
        return self
    }
}
