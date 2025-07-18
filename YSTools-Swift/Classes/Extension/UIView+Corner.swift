//
//  UIView+Corner.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/28.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIView {
    private static var roundCornersLayerKey: UInt8 = 0
    private static var roundCornersConfigKey: UInt8 = 0

    private struct RoundCornersConfig {
        let corners: UIRectCorner
        let radius: CGFloat
    }

    private var roundCornersMaskLayer: CAShapeLayer? {
        get {
            objc_getAssociatedObject(self, &UIView.roundCornersLayerKey) as? CAShapeLayer
        }
        set {
            objc_setAssociatedObject(self, &UIView.roundCornersLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var roundCornersConfig: RoundCornersConfig? {
        get {
            objc_getAssociatedObject(self, &UIView.roundCornersConfigKey) as? RoundCornersConfig
        }
        set {
            objc_setAssociatedObject(self, &UIView.roundCornersConfigKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult
    func addRoundCorners(corners: UIRectCorner, radius: CGFloat) -> Self {
        DispatchQueue.main.async { [weak self] in
            guard let self, !bounds.isEmpty else {
                return
            }
            createOrUpdateRoundCornersMask(corners: corners, radius: radius)
        }
        return self
    }

    @discardableResult
    func updateRoundCorners(corners: UIRectCorner, radius: CGFloat) -> Self {
        guard !bounds.isEmpty else {
            return self
        }

        createOrUpdateRoundCornersMask(corners: corners, radius: radius)
        return self
    }

    @discardableResult
    func removeRoundCorners() -> Self {
        if let roundCornersMask = roundCornersMaskLayer {
            roundCornersMask.removeFromSuperlayer()
            roundCornersMaskLayer = nil
            roundCornersConfig = nil

            if layer.mask == roundCornersMask {
                layer.mask = nil
            }
        }
        return self
    }

    @discardableResult
    func updateRoundCornersIfNeeded() -> Self {
        guard let config = roundCornersConfig else {
            return self
        }
        updateRoundCorners(corners: config.corners, radius: config.radius)
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

    private func createOrUpdateRoundCornersMask(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        if let existingMask = roundCornersMaskLayer {
            existingMask.path = path.cgPath
            existingMask.frame = bounds
        }
        else {
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            maskLayer.frame = bounds

            if let existingMask = layer.mask {
                let combinedMask = CALayer()
                combinedMask.frame = bounds
                combinedMask.addSublayer(existingMask)
                combinedMask.addSublayer(maskLayer)
                layer.mask = combinedMask
            }
            else {
                layer.mask = maskLayer
            }

            roundCornersMaskLayer = maskLayer
        }

        roundCornersConfig = RoundCornersConfig(corners: corners, radius: radius)
    }
}
