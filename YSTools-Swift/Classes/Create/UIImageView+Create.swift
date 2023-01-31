//
//  UIImageView+Create.swift
//  TCDoctor
//
//  Created by Joseph Koh on 2019/5/10.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    public convenience init(imageName: String?) {
        self.init()
        
        guard let imageName = imageName else {
            image = nil
            return
        }
        image = UIImage(named: imageName)
    }
    
}



protocol UIImageViewCreateProtocol {
    
}

extension UIImageViewCreateProtocol where Self: UIImageView {
    
}

extension UIImageView: UIImageViewCreateProtocol {
   
//    @discardableResult
//    internal func ys_image(name: String?) -> Self {
//        guard let name = name else {
//            return self
//        }
//        self.image = UIImage(named: name)
//        return self
//    }
//    
    @discardableResult
    public func ys_setImage(with name: String?) -> Self {
        guard let name = name else {
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
        if let placeholder = placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(withUrlStr: urlStr, placeholderImage: placeholderImage)
    }
    
    @discardableResult
    public func ys_setImage(withUrlStr urlStr: String?, placeholderImage: UIImage?) -> Self {
        guard let urlStr = urlStr,
            let url = URL.init(string: urlStr) else {
            self.image = placeholderImage
            return self
        }
        self.sd_setImage(with: url,
                         placeholderImage: placeholderImage,
                         options: [.allowInvalidSSLCertificates, .retryFailed])
        return self
    }
    
    @discardableResult
    public func ys_setImage(withURL url: URL?, placeholder: String? = nil) -> Self {
        var placeholderImage: UIImage? = nil
        if let placeholder = placeholder {
            placeholderImage = UIImage(named: placeholder)
        }
        return ys_setImage(withURL: url, placeholderImage: placeholderImage)
    }
    
    @discardableResult
    public func ys_setImage(withURL url: URL?, placeholderImage: UIImage?) -> Self {
        guard let url = url else {
            self.image = placeholderImage
            return self
        }
        self.sd_setImage(with: url,
                         placeholderImage: placeholderImage,
                         options: [.allowInvalidSSLCertificates, .retryFailed])
        return self
    }
    

}
