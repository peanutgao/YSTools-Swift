//
//  Then.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/7/17.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//


import Foundation

public protocol Then {}

public extension Then where Self: AnyObject {
    @discardableResult
    public func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}
