//
//  UIButton+Image.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2022/2/21.
//  Copyright © 2022 Joseph Koh. All rights reserved.
//

import SDWebImage
import UIKit

// MARK: - UIButtonBuildWithSDWebImageProtocol

public protocol UIButtonBuildWithSDWebImageProtocol {}

public extension UIButtonBuildWithSDWebImageProtocol where Self: UIButton {
    // MARK: - SDWebImage

    @discardableResult
    func ys_setImage(urlStr: String?, for state: UIControl.State, placeholder: String?) -> Self {
        var placeholderImage: UIImage?
        if let placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(urlStr: urlStr, for: state, placeholderImage: placeholderImage)
    }

    @discardableResult
    func ys_setImage(urlStr: String?, for state: UIControl.State, placeholderImage: UIImage? = nil) -> Self {
        guard let urlStr else {
            self.setImage(placeholderImage, for: state)
            return self
        }
        self.sd_setImage(
            with: URL(string: urlStr),
            for: state,
            placeholderImage: placeholderImage,
            options: [.allowInvalidSSLCertificates, .retryFailed],
            context: nil
        )
        return self
    }

    @discardableResult
    func ys_setImage(url: URL?, for state: UIControl.State, placeholder: String?) -> Self {
        var placeholderImage: UIImage?
        if let placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(url: url, for: state, placeholderImage: placeholderImage)
    }

    @discardableResult
    func ys_setImage(url: URL?, for state: UIControl.State, placeholderImage: UIImage?) -> Self {
        self.sd_setImage(
            with: url,
            for: state,
            placeholderImage: placeholderImage,
            options: [.allowInvalidSSLCertificates, .retryFailed],
            context: nil
        )
        return self
    }
}

// MARK: - UIButton + UIButtonBuildWithSDWebImageProtocol

extension UIButton: UIButtonBuildWithSDWebImageProtocol {}
