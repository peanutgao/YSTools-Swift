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
            frame.origin.x
        }
        set {
            var origin = frame.origin
            origin.x = newValue
            frame.origin = origin
        }
    }

    var y: CGFloat {
        get {
            frame.origin.y
        }
        set {
            var origin = frame.origin
            origin.y = newValue
            frame.origin = origin
        }
    }

    var width: CGFloat {
        get {
            bounds.size.width
        }
        set {
            var size = bounds.size
            size.width = newValue
            bounds.size = size
        }
    }

    var height: CGFloat {
        get {
            bounds.size.height
        }
        set {
            var size = bounds.size
            size.height = newValue
            bounds.size = size
        }
    }

    var top: CGFloat {
        get {
            frame.origin.y
        }
        set {
            var origin = frame.origin
            origin.y = newValue
            frame.origin = origin
        }
    }

    var left: CGFloat {
        get {
            frame.origin.x
        }
        set {
            var origin = frame.origin
            origin.x = newValue
            frame.origin = origin
        }
    }

    var bottom: CGFloat {
        get {
            frame.maxY
        }
        set {
            var origin = frame.origin
            origin.y = newValue - frame.origin.y
            frame.origin = origin
        }
    }

    var right: CGFloat {
        get {
            frame.maxX
        }
        set {
            var origin = frame.origin
            origin.x = newValue - frame.origin.x
            frame.origin = origin
        }
    }

    var centerX: CGFloat {
        get {
            center.x
        }
        set {
            center.x = newValue
        }
    }

    var centerY: CGFloat {
        get {
            center.y
        }
        set {
            center.y = newValue
        }
    }

    var midX: CGFloat {
        get {
            frame.midX
        }
        set {
            var origin = frame.origin
            origin.x = newValue - frame.size.width * 0.5
            frame.origin = origin
        }
    }

    var midY: CGFloat {
        get {
            frame.midY
        }
        set {
            var origin = frame.origin
            origin.y = newValue - frame.size.height * 0.5
            frame.origin = origin
        }
    }
}
