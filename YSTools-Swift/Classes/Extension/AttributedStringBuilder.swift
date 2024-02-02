//
// *************************************************
// Created by Joseph Koh on 2023/11/8.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2023/11/8 11:14
// *************************************************
//

import UIKit

// MARK: - AttributedStringBuilder

public struct AttributedStringBuilder {
    private var string = NSMutableAttributedString()

    public init(_ text: String? = nil) {
        string = NSMutableAttributedString(string: text ?? "")
    }

    @discardableResult
    public func append(_ text: String?) -> AttributedStringBuilder {
        let attributedString = NSAttributedString(string: text ?? "")
        string.append(attributedString)
        return self
    }

    @discardableResult
    public func append(_ text: String?,
                       withAttributes attributes: [NSAttributedString.Key: Any]) -> AttributedStringBuilder
    {
        let attributedString = NSAttributedString(string: text ?? "", attributes: attributes)
        string.append(attributedString)
        return self
    }

    @discardableResult
    public func appendImage(_ image: UIImage?, size: CGSize) -> AttributedStringBuilder {
        guard let image else {
            return self
        }
        let textAttachment = NSTextAttachment()
        textAttachment.image = image
        let mid = (UIFont.systemFont(ofSize: UIFont.systemFontSize).capHeight - size.height).rounded() / 2
        textAttachment.bounds = CGRect(x: 0, y: mid, width: size.width, height: size.height)

        let attributedStringWithImage = NSAttributedString(attachment: textAttachment)
        string.append(attributedStringWithImage)

        return self
    }

    @discardableResult
    public func setAttributes(_ attributes: [NSAttributedString.Key: Any]) -> AttributedStringBuilder {
        let range = NSRange(location: 0, length: string.length)
        string.addAttributes(attributes, range: range)
        return self
    }

    public func build() -> NSMutableAttributedString {
        string
    }
}

public extension NSMutableParagraphStyle {
    @discardableResult
    func then(_ block: (NSMutableParagraphStyle) -> Void) -> NSMutableParagraphStyle {
        block(self)
        return self
    }
}
