    //
// *************************************************
// Created by Joseph Koh on 2024/4/1.
// Author: Joseph Koh
// Create Time: 2024/4/1 12:58
// *************************************************
//

import UIKit

public protocol NSMutableParagraphStyleCreateProtocol {
}

public extension NSMutableParagraphStyleCreateProtocol where Self: NSMutableParagraphStyle {
    @discardableResult
    func setLineSpacing(_ spacing: CGFloat) -> Self {
        lineSpacing = spacing
        return self
    }

    @discardableResult
    func setParagraphSpacing(_ spacing: CGFloat) -> Self {
        paragraphSpacing = spacing
        return self
    }

    @discardableResult
    func setAlignment(_ alignment: NSTextAlignment) -> Self {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func setFirstLineHeadIndent(_ indent: CGFloat) -> Self {
        firstLineHeadIndent = indent
        return self
    }

    @discardableResult
    func setHeadIndent(_ indent: CGFloat) -> Self {
        headIndent = indent
        return self
    }

    @discardableResult
    func setTailIndent(_ indent: CGFloat) -> Self {
        tailIndent = indent
        return self
    }

    @discardableResult
    func setLineBreakMode(_ mode: NSLineBreakMode) -> Self {
        lineBreakMode = mode
        return self
    }

    @discardableResult
    func setMinimumLineHeight(_ height: CGFloat) -> Self {
        minimumLineHeight = height
        return self
    }

    @discardableResult
    func setMaximumLineHeight(_ height: CGFloat) -> Self {
        maximumLineHeight = height
        return self
    }

    @discardableResult
    func setBaseWritingDirection(_ direction: NSWritingDirection) -> Self {
        baseWritingDirection = direction
        return self
    }

    @discardableResult
    func setLineHeightMultiple(_ multiple: CGFloat) -> Self {
        lineHeightMultiple = multiple
        return self
    }

    @discardableResult
    func setParagraphSpacingBefore(_ spacing: CGFloat) -> Self {
        paragraphSpacingBefore = spacing
        return self
    }

    @discardableResult
    func setHyphenationFactor(_ factor: Float) -> Self {
        hyphenationFactor = factor
        return self
    }

    @discardableResult
    func setTabStops(_ stops: [NSTextTab]) -> Self {
        tabStops = stops
        return self
    }

    @discardableResult
    func setDefaultTabInterval(_ interval: CGFloat) -> Self {
        defaultTabInterval = interval
        return self
    }

    @discardableResult
    func setAllowsDefaultTighteningForTruncation(_ allows: Bool) -> Self {
        allowsDefaultTighteningForTruncation = allows
        return self
    }
}

extension NSMutableParagraphStyle: NSMutableParagraphStyleCreateProtocol {
}
