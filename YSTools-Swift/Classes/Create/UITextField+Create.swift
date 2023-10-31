//
//  UITextField+Create.swift
//  YSTools-Swift
//
//  Created by Sallie Xiong on 2019/5/6.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public protocol UITextFieldCreateProtocol {
    
}

extension UITextFieldCreateProtocol where Self: UITextField {
    
    @discardableResult
    public func ys_text(_ text: String?) -> Self {
        if let text = text { self.text = text}
        return self
    }
    
    @discardableResult
    public func ys_font(_ font: UIFont?) -> Self {
        if let font = font { self.font = font}
        return self
    }
    
    @discardableResult
    public func ys_textColor(_ color: UIColor?) -> Self {
        if let color = color { self.textColor = color}
        return self
    }
    
    @discardableResult
    public func ys_textAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func ys_placeholder(_ placeholder: String?) -> Self {
        if let placeholder = placeholder { self.placeholder = placeholder}
        return self
    }
    
    @discardableResult
    public func ys_borderStyle(_ style: UITextField.BorderStyle) -> Self {
        self.borderStyle = style
        return self
    }
    
    @discardableResult
    public func ys_keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }
    
    @discardableResult
    public func ys_delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func ys_clearButtonMode(_ mode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = mode
        return self
    }
    
    @discardableResult
    public func ys_adjustsFontSizeToFitWidth(_ b: Bool = false) -> Self {
        self.adjustsFontSizeToFitWidth = b
        return self
    }
    
    
}

extension UITextField: UITextFieldCreateProtocol {
   
    
}
