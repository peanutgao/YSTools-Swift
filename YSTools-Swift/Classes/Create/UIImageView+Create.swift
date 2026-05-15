//
//  UIImageView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/10.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIImageView {
    convenience init(imageName: String?) {
        self.init()

        guard let imageName else {
            image = nil
            return
        }
        image = UIImage(named: imageName)
    }
}

// MARK: - UIImageViewCreateProtocol

protocol UIImageViewCreateProtocol {}

extension UIImageViewCreateProtocol where Self: UIImageView {}

// MARK: - UIImageView + UIImageViewCreateProtocol

extension UIImageView: UIImageViewCreateProtocol {
    @discardableResult
    public func ys_tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    public func ys_isHighlighted(_ b: Bool) -> Self {
        self.isHighlighted = b
        return self
    }

    @discardableResult
    public func ys_highlightedImage(_ image: UIImage?) -> Self {
        self.highlightedImage = image
        return self
    }

    @discardableResult
    public func ys_animationImages(_ images: [UIImage]?) -> Self {
        self.animationImages = images
        return self
    }

    @discardableResult
    public func ys_animationDuration(_ duration: TimeInterval) -> Self {
        self.animationDuration = duration
        return self
    }

    @discardableResult
    public func ys_animationRepeatCount(_ count: Int) -> Self {
        self.animationRepeatCount = count
        return self
    }

    @discardableResult
    public func ys_renderingMode(_ mode: UIImage.RenderingMode) -> Self {
        self.image = self.image?.withRenderingMode(mode)
        return self
    }

    @discardableResult
    public func ys_setImage(with name: String?) -> Self {
        guard let name else {
            self.image = nil
            return self
        }
        self.image = UIImage(named: name)
        return self
    }

    @discardableResult
    public func ys_setImage(with image: UIImage?) -> Self {
        self.image = image
        return self
    }
}
