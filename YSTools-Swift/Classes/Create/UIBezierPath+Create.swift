//
//  UIBezierPath+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIBezierPathCreateProtocol

public protocol UIBezierPathCreateProtocol {}

public extension UIBezierPathCreateProtocol where Self: UIBezierPath {
    @discardableResult
    func ys_move(to point: CGPoint) -> Self {
        self.move(to: point)
        return self
    }

    @discardableResult
    func ys_addLine(to point: CGPoint) -> Self {
        self.addLine(to: point)
        return self
    }

    @discardableResult
    func ys_addArc(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> Self {
        self.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return self
    }

    @discardableResult
    func ys_addCurve(to endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> Self {
        self.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        return self
    }

    @discardableResult
    func ys_addQuadCurve(to endPoint: CGPoint, controlPoint: CGPoint) -> Self {
        self.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        return self
    }

    @discardableResult
    func ys_close() -> Self {
        self.close()
        return self
    }

    @discardableResult
    func ys_lineWidth(_ width: CGFloat) -> Self {
        self.lineWidth = width
        return self
    }

    @discardableResult
    func ys_lineCapStyle(_ style: CGLineCap) -> Self {
        self.lineCapStyle = style
        return self
    }

    @discardableResult
    func ys_lineJoinStyle(_ style: CGLineJoin) -> Self {
        self.lineJoinStyle = style
        return self
    }

    @discardableResult
    func ys_miterLimit(_ limit: CGFloat) -> Self {
        self.miterLimit = limit
        return self
    }

    @discardableResult
    func ys_flatness(_ flatness: CGFloat) -> Self {
        self.flatness = flatness
        return self
    }

    @discardableResult
    func ys_usesEvenOddFillRule(_ b: Bool) -> Self {
        self.usesEvenOddFillRule = b
        return self
    }

    @discardableResult
    func ys_setLineDash(_ pattern: [CGFloat], count: Int, phase: CGFloat) -> Self {
        var p = pattern
        self.setLineDash(&p, count: count, phase: phase)
        return self
    }
}

extension UIBezierPath: UIBezierPathCreateProtocol {}
