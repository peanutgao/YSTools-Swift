//
//  UIButton+Image.swift
//  SCDoctor
//
//  Created by Joseph Koh on 2022/2/21.
//  Copyright © 2022 Joseph Koh. All rights reserved.
//

import UIKit
import SDWebImage

public protocol UIButtonBuildWithSDWebImageProtocol {

}


public extension UIButtonBuildWithSDWebImageProtocol where Self: UIButton {
    // MARK: - SDWebImage
    @discardableResult
    public func ys_setImage(withUrlStr urlStr: String?, for state: UIControl.State, placeholder: String?) -> Self {
        var placeholderImage: UIImage?
        if let placeholder = placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(withUrlStr: urlStr, for: state, placeholderImage: placeholderImage)
    }
    
    @discardableResult
    public func ys_setImage(withUrlStr urlStr: String?, for state: UIControl.State, placeholderImage: UIImage? = nil) -> Self {
        guard let urlStr = urlStr else {
            self.setImage(placeholderImage, for: state)
            return self
        }
        self.sd_setImage(with: URL.init(string: urlStr),
                         for: state,
                         placeholderImage: placeholderImage,
                         options: [.allowInvalidSSLCertificates, .retryFailed],
                         context: nil)
        return self
    }
    
    @discardableResult
    public func ys_setImage(withUrl url: URL?, for state: UIControl.State, placeholder: String?) -> Self {
        var placeholderImage: UIImage?
        if let placeholder = placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(withUrl: url, for: state, placeholderImage: placeholderImage)
    }
    
    @discardableResult
    public func ys_setImage(withUrl url: URL?, for state: UIControl.State, placeholderImage: UIImage?) -> Self {
        self.sd_setImage(with: url,
                         for: state,
                         placeholderImage: placeholderImage,
                         options: [.allowInvalidSSLCertificates, .retryFailed],
                         context: nil)
        return self
    }
}


extension UIButton: UIButtonBuildWithSDWebImageProtocol {
   
    
}
