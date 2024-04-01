//
// *************************************************
// Created by Joseph Koh on 2023/11/14.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/11/14 17:36
// *************************************************
//

import UIKit

public class PaddingLabel: UILabel {
    public var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override public var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let height = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: padding)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(
            top: -padding.top,
            left: -padding.left,
            bottom: -padding.bottom,
            right: -padding.right
        )
        return textRect.inset(by: invertedInsets)
    }
}
