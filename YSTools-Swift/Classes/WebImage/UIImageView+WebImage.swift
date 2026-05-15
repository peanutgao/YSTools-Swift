//
//  UIImageView+WebImage.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//

import SDWebImage
import UIKit

public extension UIImageView {
    @discardableResult
    func ys_setImage(
        withUrlStr urlStr: String?,
        placeholder: String? = nil,
        options: SDWebImageOptions = [.retryFailed]
    ) -> Self {
        var placeholderImage: UIImage?
        if let placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(withUrlStr: urlStr, placeholderImage: placeholderImage, options: options)
    }

    @discardableResult
    func ys_setImage(
        withUrlStr urlStr: String?,
        placeholderImage: UIImage?,
        options: SDWebImageOptions = [.retryFailed]
    ) -> Self {
        guard let urlStr,
              let url = URL(string: urlStr)
        else {
            image = placeholderImage
            return self
        }
        sd_setImage(
            with: url,
            placeholderImage: placeholderImage,
            options: options
        )
        return self
    }

    @discardableResult
    func ys_setImage(
        withURL url: URL?,
        placeholder: String? = nil,
        options: SDWebImageOptions = [.retryFailed]
    ) -> Self {
        var placeholderImage: UIImage?
        if let placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(withURL: url, placeholderImage: placeholderImage, options: options)
    }

    @discardableResult
    func ys_setImage(
        withURL url: URL?,
        placeholderImage: UIImage?,
        options: SDWebImageOptions = [.retryFailed]
    ) -> Self {
        guard let url else {
            image = placeholderImage
            return self
        }
        sd_setImage(
            with: url,
            placeholderImage: placeholderImage,
            options: options
        )
        return self
    }
}
