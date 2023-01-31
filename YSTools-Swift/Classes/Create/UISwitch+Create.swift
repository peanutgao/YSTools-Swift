//
//  UISwitch+Create.swift
//  SCDoctor
//
//  Created by Joseph Koh on 2019/8/8.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public protocol UISwitchCreateProtocol {
    
}

public extension UISwitchCreateProtocol where Self: UISwitch  {
    
    @discardableResult
    func ys_onTintColor(_ color: UIColor?) -> Self {
        self.onTintColor = color
        return self
    }
    
    @discardableResult
    func ys_thumbTintColor(_ color: UIColor?) -> Self {
        self.thumbTintColor = color
        return self
    }
    
    @discardableResult
    func ys_onImage(_ image: UIImage?) -> Self {
        self.onImage = image
        return self
    }

    @discardableResult
    func ys_offImage(_ image: UIImage?) -> Self {
        self.offImage = image
        return self
    }

    @discardableResult
    func ys_isOn(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }
    
}


extension UISwitch: UISwitchCreateProtocol {
    
    
}
