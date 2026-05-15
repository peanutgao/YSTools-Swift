//
//  UIProgressView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UIProgressViewCreateProtocol

public protocol UIProgressViewCreateProtocol {}

public extension UIProgressViewCreateProtocol where Self: UIProgressView {
    @discardableResult
    func ys_progress(_ progress: Float) -> Self {
        self.progress = progress
        return self
    }

    @discardableResult
    func ys_setProgress(_ progress: Float, animated: Bool) -> Self {
        self.setProgress(progress, animated: animated)
        return self
    }

    @discardableResult
    func ys_progressViewStyle(_ style: UIProgressView.Style) -> Self {
        self.progressViewStyle = style
        return self
    }

    @discardableResult
    func ys_progressTintColor(_ color: UIColor?) -> Self {
        self.progressTintColor = color
        return self
    }

    @discardableResult
    func ys_trackTintColor(_ color: UIColor?) -> Self {
        self.trackTintColor = color
        return self
    }

    @discardableResult
    func ys_progressImage(_ image: UIImage?) -> Self {
        self.progressImage = image
        return self
    }

    @discardableResult
    func ys_trackImage(_ image: UIImage?) -> Self {
        self.trackImage = image
        return self
    }

    @discardableResult
    func ys_observedProgress(_ progress: Progress?) -> Self {
        self.observedProgress = progress
        return self
    }
}

extension UIProgressView: UIProgressViewCreateProtocol {}
