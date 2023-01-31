//
//  UIControl+Create.swift
//  SCDoctor
//
//  Created by Joseph Koh on 2019/7/31.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public protocol UIControlCreateProtocol {
    
}

extension UIControlCreateProtocol where Self: UIControl {
    
    @discardableResult
    public func ys_isEnable(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
    
    
    @discardableResult
    public func ys_isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }
    
    @discardableResult
    public func ys_addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Self {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }

}

extension UIButton: UIControlCreateProtocol {
    
}


extension UISwitch: UIControlCreateProtocol {
    
}
