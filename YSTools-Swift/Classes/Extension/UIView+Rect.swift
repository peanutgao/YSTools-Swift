//
//  UIView+Rect.swift
//  UIImage(data: data)
//
//  Created by Joseph Koh on 2019/4/29.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension UIView {
    var x: CGFloat {
        get {
            self.frame.origin.x
        }
        set {
            var origin = self.frame.origin
            origin.x = newValue
            self.frame.origin = origin
        }
    }

    var y: CGFloat {
        get {
            self.frame.origin.y
        }
        set {
            var origin = self.frame.origin
            origin.y = newValue
            self.frame.origin = origin
        }
    }

    var width: CGFloat {
        get {
            self.bounds.size.width
        }
        set {
            var size = self.bounds.size
            size.width = newValue
            self.bounds.size = size
        }
    }

    var height: CGFloat {
        get {
            self.bounds.size.height
        }
        set {
            var size = self.bounds.size
            size.height = newValue
            self.bounds.size = size
        }
    }

    var top: CGFloat {
        get {
            self.frame.origin.y
        }
        set {
            var origin = self.frame.origin
            origin.y = newValue
            self.frame.origin = origin
        }
    }

    var left: CGFloat {
        get {
            self.frame.origin.x
        }
        set {
            var origin = self.frame.origin
            origin.x = newValue
            self.frame.origin = origin
        }
    }

    var bottom: CGFloat {
        get {
            self.frame.maxY
        }
        set {
            var origin = self.frame.origin
            origin.y = newValue - self.frame.origin.y
            self.frame.origin = origin
        }
    }

    var right: CGFloat {
        get {
            self.frame.maxX
        }
        set {
            var origin = self.frame.origin
            origin.x = newValue - self.frame.origin.x
            self.frame.origin = origin
        }
    }

    var centerX: CGFloat {
        get {
            self.center.x
        }
        set {
            self.center.x = newValue
        }
    }

    var centerY: CGFloat {
        get {
            self.center.y
        }
        set {
            self.center.y = newValue
        }
    }

    var midX: CGFloat {
        get {
            self.frame.midX
        }
        set {
            var origin = self.frame.origin
            origin.x = newValue - self.frame.size.width * 0.5
            self.frame.origin = origin
        }
    }

    var midY: CGFloat {
        get {
            self.frame.midY
        }
        set {
            var origin = self.frame.origin
            origin.y = newValue - self.frame.size.height * 0.5
            self.frame.origin = origin
        }
    }
}
