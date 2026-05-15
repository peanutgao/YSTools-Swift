//
//  NSMutableAttributedString+Create.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//  Copyright © 2026 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - NSMutableAttributedStringCreateProtocol

public protocol NSMutableAttributedStringCreateProtocol {}

public extension NSMutableAttributedStringCreateProtocol where Self: NSMutableAttributedString {
    @discardableResult
    func ys_addAttribute(_ name: NSAttributedString.Key, value: Any, range: NSRange? = nil) -> Self {
        guard let r = safeRange(range) else {
            return self
        }
        addAttribute(name, value: value, range: r)
        return self
    }

    @discardableResult
    func ys_addAttributes(_ attrs: [NSAttributedString.Key: Any], range: NSRange? = nil) -> Self {
        guard let r = safeRange(range) else {
            return self
        }
        addAttributes(attrs, range: r)
        return self
    }

    @discardableResult
    func ys_font(_ font: UIFont, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.font, value: font, range: range)
    }

    @discardableResult
    func ys_foregroundColor(_ color: UIColor, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.foregroundColor, value: color, range: range)
    }

    @discardableResult
    func ys_backgroundColor(_ color: UIColor, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.backgroundColor, value: color, range: range)
    }

    @discardableResult
    func ys_kern(_ kern: CGFloat, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.kern, value: kern, range: range)
    }

    @discardableResult
    func ys_underline(_ style: NSUnderlineStyle, color: UIColor? = nil, range: NSRange? = nil) -> Self {
        ys_addAttribute(.underlineStyle, value: style.rawValue, range: range)
        if let color {
            ys_addAttribute(.underlineColor, value: color, range: range)
        }
        return self
    }

    @discardableResult
    func ys_strikethrough(_ style: NSUnderlineStyle, color: UIColor? = nil, range: NSRange? = nil) -> Self {
        ys_addAttribute(.strikethroughStyle, value: style.rawValue, range: range)
        if let color {
            ys_addAttribute(.strikethroughColor, value: color, range: range)
        }
        return self
    }

    @discardableResult
    func ys_strokeColor(_ color: UIColor, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.strokeColor, value: color, range: range)
    }

    @discardableResult
    func ys_strokeWidth(_ width: CGFloat, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.strokeWidth, value: width, range: range)
    }

    @discardableResult
    func ys_paragraphStyle(_ style: NSParagraphStyle, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.paragraphStyle, value: style, range: range)
    }

    @discardableResult
    func ys_link(_ url: URL, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.link, value: url, range: range)
    }

    @discardableResult
    func ys_baselineOffset(_ offset: CGFloat, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.baselineOffset, value: offset, range: range)
    }

    @discardableResult
    func ys_shadow(_ shadow: NSShadow, range: NSRange? = nil) -> Self {
        return ys_addAttribute(.shadow, value: shadow, range: range)
    }

    @discardableResult
    func ys_append(_ string: NSAttributedString) -> Self {
        append(string)
        return self
    }

    @discardableResult
    func ys_appendString(_ string: String, attributes: [NSAttributedString.Key: Any]? = nil) -> Self {
        append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    @discardableResult
    func ys_appendImage(_ image: UIImage, bounds: CGRect = .zero) -> Self {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        append(NSAttributedString(attachment: attachment))
        return self
    }
}

extension NSMutableAttributedString: NSMutableAttributedStringCreateProtocol {}

private extension NSMutableAttributedString {
    func safeRange(_ range: NSRange?) -> NSRange? {
        guard length > 0 else {
            return nil
        }

        guard let range else {
            return NSRange(location: 0, length: length)
        }

        guard range.location != NSNotFound,
              range.location >= 0,
              range.length >= 0,
              range.location < length else {
            return nil
        }

        let availableLength = length - range.location
        return NSRange(location: range.location, length: min(range.length, availableLength))
    }
}
