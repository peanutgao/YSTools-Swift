//
//  UIView+Anim.swift
//  
//
//  Created by Joseph on 2025/12/12.
//

import UIKit

public enum YSShakeDirection {
	case horizontal
	case vertical
}

public extension UIView {
	/// Shake 
	/// - Parameters:
	///   - direction: Default is `.horizontal`.
	///   - duration: Total duration.
	///   - offset: Translation offset in points.
	///   - times: Number of back-and-forth shakes. Values <= 0 will be treated as 1.
	///   - damping: Amplitude decay per shake. Typical range is (0, 1].
	///   - completion: Called on main thread after animation completes.
	@discardableResult
	public func shake(
		direction: YSShakeDirection = .horizontal,
		duration: TimeInterval = 0.45,
		offset: CGFloat = 8,
		times: Int = 6,
		damping: CGFloat = 0.9,
		completion: (() -> Void)? = nil
	) -> Self {
		let animationKey = "ys_shake"
		layer.removeAnimation(forKey: animationKey)

		if UIAccessibility.isReduceMotionEnabled {
			completion?()
			return self
		}

		let axisKeyPath: String
		switch direction {
		case .horizontal:
			axisKeyPath = "transform.translation.x"
		case .vertical:
			axisKeyPath = "transform.translation.y"
		}

		let resolvedTimes = max(1, times)
		let resolvedDamping = max(0, min(1, damping))

		var values: [CGFloat] = [0]
		values.reserveCapacity(resolvedTimes * 2 + 2)
		var current = offset
		for idx in 0..<resolvedTimes {
			let sign: CGFloat = (idx % 2 == 0) ? 1 : -1
			values.append(sign * current)
			values.append(-sign * current)
			current *= resolvedDamping
		}
		values.append(0)

		CATransaction.begin()
		CATransaction.setCompletionBlock {
			DispatchQueue.main.async { completion?() }
		}

		let animation = CAKeyframeAnimation(keyPath: axisKeyPath)
		animation.values = values
		animation.calculationMode = .cubic
		let count = max(2, values.count)
		animation.keyTimes = (0..<count).map { NSNumber(value: Double($0) / Double(count - 1)) }
		animation.timingFunctions = Array(
			repeating: CAMediaTimingFunction(name: .easeInEaseOut),
			count: max(1, count - 1)
		)
		animation.duration = max(0.01, duration)
		animation.isRemovedOnCompletion = true

		layer.add(animation, forKey: animationKey)
		CATransaction.commit()

		return self
	}

	/// Swing 
	/// - Parameters:
	///   - angle: Rotation angle in degrees.
	///   - duration: Total duration.
	///   - times: Number of back-and-forth swings. Values <= 0 will be treated as 1.
	///   - damping: Amplitude decay per swing. Typical range is (0, 1].
	///   - completion: Called on main thread after animation completes.
	@discardableResult
	public func swing(
		angle: CGFloat = 12,
		duration: TimeInterval = 0.55,
		times: Int = 6,
		damping: CGFloat = 0.85,
		completion: (() -> Void)? = nil
	) -> Self {
		let animationKey = "ys_swing"
		layer.removeAnimation(forKey: animationKey)

		if UIAccessibility.isReduceMotionEnabled {
			completion?()
			return self
		}

		let resolvedTimes = max(1, times)
		let resolvedDamping = max(0, min(1, damping))
		let baseRadians = angle * CGFloat.pi / 180

		var values: [CGFloat] = [0]
		values.reserveCapacity(resolvedTimes * 2 + 2)
		var current = baseRadians
		for _ in 0..<resolvedTimes {
			values.append(current)
			values.append(-current)
			current *= resolvedDamping
		}
		values.append(0)

		CATransaction.begin()
		CATransaction.setCompletionBlock {
			DispatchQueue.main.async { completion?() }
		}

		let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		animation.values = values
		animation.calculationMode = .cubic
		let count = max(2, values.count)
		animation.keyTimes = (0..<count).map { NSNumber(value: Double($0) / Double(count - 1)) }
		animation.timingFunctions = Array(
			repeating: CAMediaTimingFunction(name: .easeInEaseOut),
			count: max(1, count - 1)
		)
		animation.duration = max(0.01, duration)
		animation.isRemovedOnCompletion = true

		layer.add(animation, forKey: animationKey)
		CATransaction.commit()

		return self
	}
}
