//
//  UIImageView+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/10.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import SDWebImage
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
    ///    @discardableResult
    ///    internal func ys_image(name: String?) -> Self {
    ///        guard let name = name else {
    ///            return self
    ///        }
    ///        self.image = UIImage(named: name)
    ///        return self
    ///    }
    ///
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

    @discardableResult
    public func ys_setImage(withUrlStr urlStr: String?, placeholder: String? = nil) -> Self {
        var placeholderImage: UIImage? = nil
        if let placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(withUrlStr: urlStr, placeholderImage: placeholderImage)
    }

    @discardableResult
    public func ys_setImage(withUrlStr urlStr: String?, placeholderImage: UIImage?) -> Self {
        guard let urlStr,
              let url = URL(string: urlStr)
        else {
            self.image = placeholderImage
            return self
        }
        self.sd_setImage(
            with: url,
            placeholderImage: placeholderImage,
            options: [.allowInvalidSSLCertificates, .retryFailed]
        )
        return self
    }

    @discardableResult
    public func ys_setImage(withURL url: URL?, placeholder: String? = nil) -> Self {
        var placeholderImage: UIImage? = nil
        if let placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(withURL: url, placeholderImage: placeholderImage)
    }

    @discardableResult
    public func ys_setImage(withURL url: URL?, placeholderImage: UIImage?) -> Self {
        guard let url else {
            self.image = placeholderImage
            return self
        }
        self.sd_setImage(
            with: url,
            placeholderImage: placeholderImage,
            options: [.allowInvalidSSLCertificates, .retryFailed]
        )
        return self
    }
}
