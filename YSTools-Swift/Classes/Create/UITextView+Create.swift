//
//  UITextView+Create.swift
//  TCDoctor
//
//  Created by Joseph Koh on 2019/5/15.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit


public protocol UITextViewCreateProtocol {
    
}

extension UITextViewCreateProtocol where Self: UITextView {
    
    @discardableResult
    public func ys_text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func ys_font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    public func ys_textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    public func ys_textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

}

extension UITextView: UITextViewCreateProtocol {


}
