//
//  UIScrollView+Create.swift
//  TCDoctor
//
//  Created by Joseph Koh on 2019/5/11.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public protocol UIScrollViewCreateProtocol {
    
}

public extension UIScrollViewCreateProtocol where Self: UIScrollView {
    @discardableResult
    public func ys_delegate(_ delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func ys_showsVerticalScrollIndicator(_ b: Bool) -> Self {
        self.showsVerticalScrollIndicator = b
        return self
    }
    
    @discardableResult
    public func ys_showsHorizontalScrollIndicator(_ b: Bool) -> Self {
        showsHorizontalScrollIndicator = b
        return self
    }
    
    @discardableResult
    public func ys_indicatorStyle(_ style: UIScrollView.IndicatorStyle) -> Self {
        self.indicatorStyle = style
        return self
    }
    
    @discardableResult
    public func ys_bounces(_ b: Bool) -> Self {
        self.bounces = b
        return self
    }
    
    @discardableResult
    public func ys_contentSize(_ size: CGSize) -> Self {
        self.contentSize = size
        return self
    }
    
}

extension UIScrollView: UIScrollViewCreateProtocol {

}


