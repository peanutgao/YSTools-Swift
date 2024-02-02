//
// *************************************************
// Created by Joseph Koh on 2023/11/15.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2023/11/15 23:32
// *************************************************
//

public extension UIView {
    // different inner shadow styles
    enum innerShadowSide {
        case all, left, right, top, bottom, topAndLeft, topAndRight, bottomAndLeft, bottomAndRight, exceptLeft, exceptRight, exceptTop, exceptBottom
    }

    // define function to add inner shadow
    @discardableResult
    func addInnerShadow(onSide: innerShadowSide, shadowColor: UIColor, shadowSize: CGFloat, cornerRadius _: CGFloat = 0.0, shadowOpacity: Float) -> CAShapeLayer {
        // define and set a shadow layer
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowSize
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd

        // define shadow path
        let shadowPath = CGMutablePath()

        // define outer rectangle to restrict drawing area
        let insetRect = bounds.insetBy(dx: -shadowSize * 2.0, dy: -shadowSize * 2.0)

        // define inner rectangle for mask
        let result: CGRect
        switch onSide {
        case .all:
            result = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
        case .left:
            result = CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
        case .right:
            result = CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
        case .top:
            result = CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
        case .bottom:
            result = CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
        case .topAndLeft:
            result = CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
        case .topAndRight:
            result = CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
        case .bottomAndLeft:
            result = CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
        case .bottomAndRight:
            result = CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
        case .exceptLeft:
            result = CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
        case .exceptRight:
            result = CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
        case .exceptTop:
            result = CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
        case .exceptBottom:
            result = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
        }
        let innerFrame: CGRect = result

        // add outer and inner rectangle to shadow path
        shadowPath.addRect(insetRect)
        shadowPath.addRect(innerFrame)

        // set shadow path as show layer's
        shadowLayer.path = shadowPath

        // add shadow layer as a sublayer
        layer.addSublayer(shadowLayer)

        // hide outside drawing area
        clipsToBounds = true
        return shadowLayer
    }
}
