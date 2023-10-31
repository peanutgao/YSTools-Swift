//
//  UIView+Rect.swift
//  UIImage(data: data)
//
//  Created by Joseph Koh on 2019/4/29.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension UIView {
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var origin = self.frame.origin
            origin.x = newValue
            self.frame.origin = origin
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var origin = self.frame.origin
            origin.y = newValue
            self.frame.origin = origin
        }
    }
    
    public var width: CGFloat {
        get {
            return self.bounds.size.width
        }
        set {
            var size = self.bounds.size
            size.width = newValue
            self.bounds.size = size
        }
    }
    
    public var height: CGFloat {
        get {
            return self.bounds.size.height
        }
        set {
            var size = self.bounds.size
            size.height = newValue
            self.bounds.size = size
        }
    }
    
    public var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var origin = self.frame.origin
            origin.y = newValue
            self.frame.origin = origin
        }
    }
    
    
    public var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var origin = self.frame.origin
            origin.x = newValue
            self.frame.origin = origin
        }
    }
    
    public var bottom: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            var origin = self.frame.origin
            origin.y = newValue - self.frame.origin.y
            self.frame.origin = origin
        }
    }
    
    public var right: CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            var origin = self.frame.origin
            origin.x = newValue - self.frame.origin.x
            self.frame.origin = origin
        }
    }
    
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }

    public var midX: CGFloat {
        get {
            return self.frame.midX
        }
        set {
            var origin = self.frame.origin
            origin.x = newValue - self.frame.size.width * 0.5
            self.frame.origin = origin
        }
    }
    
    public var midY: CGFloat {
        get {
            return self.frame.midY
        }
        set {
            var origin = self.frame.origin
            origin.y = newValue - self.frame.size.height * 0.5
            self.frame.origin = origin
        }
    }
}
