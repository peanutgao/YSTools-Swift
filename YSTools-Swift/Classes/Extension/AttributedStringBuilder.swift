//
// *************************************************
// Created by Joseph Koh on 2023/11/8.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/11/8 11:14
// *************************************************
//

import UIKit

// MARK: - AttributedStringBuilder

public final class AttributedStringBuilder {
    // 当前总长度
    public var length: Int { buffer.length }

    // MARK: Init

    public init(_ text: String? = nil, attributes: [NSAttributedString.Key: Any]? = nil) {
        if let attributes {
            buffer = NSMutableAttributedString(string: text ?? "", attributes: attributes)
        }
        else {
            buffer = NSMutableAttributedString(string: text ?? "")
        }
        if buffer.length > 0 {
            segments.append(NSRange(location: 0, length: buffer.length))
        }
    }

    private let buffer: NSMutableAttributedString
    private var segments: [NSRange] = []
    private var lastRange: NSRange? { segments.last }
    private func combinedLastRanges(_ count: Int) -> NSRange? {
        guard count > 0, count <= segments.count else {
            return nil
        }
        let tail = segments.suffix(count)
        guard var union = tail.first else {
            return nil
        }
        for range in tail.dropFirst() {
            let start = min(union.location, range.location)
            let end = max(union.location + union.length, range.location + range.length)
            union = NSRange(location: start, length: end - start)
        }
        return union
    }

    @discardableResult
    public func append(_ text: String?, attributes: [NSAttributedString.Key: Any]? = nil) -> Self {
        guard let text, !text.isEmpty else {
            return self
        }
        let start = buffer.length
        let part = NSAttributedString(string: text, attributes: attributes)
        buffer.append(part)
        segments.append(NSRange(location: start, length: part.length))
        return self
    }

    @discardableResult
    public func append(_ text: String?) -> Self { append(text, attributes: nil) }

    /// - Deprecated: 请使用 `append(_:attributes:)`。
    @available(*, deprecated, message: "请使用 append(_:attributes:)。")
    @discardableResult
    public func append(
        _ text: String?,
        withAttributes attributes: [NSAttributedString.Key: Any]
    ) -> Self { append(text, attributes: attributes) }

    @discardableResult
    public func append(_ attr: NSAttributedString?) -> Self {
        guard let attr, attr.length > 0 else {
            return self
        }
        let start = buffer.length
        buffer.append(attr)
        segments.append(NSRange(location: start, length: attr.length))
        return self
    }

    // MARK: - 图片

    /// 追加图片（按给定 size 并基于参考字体垂直居中）。
    /// - Parameters:
    ///   - image: UIImage
    ///   - size: 目标尺寸
    ///   - referenceFont: 用于计算 y 偏移的参考字体（默认系统字体 14）
    ///   - yOffset: 手动附加偏移（在自动居中基础上再调整）
    @discardableResult
    public func appendImage(
        _ image: UIImage?,
        size: CGSize,
        referenceFont: UIFont = .systemFont(ofSize: 14),
        yOffset: CGFloat = 0
    ) -> Self {
        guard let image else {
            return self
        }
        let attachment = NSTextAttachment()
        attachment.image = image
        let mid = (referenceFont.capHeight - size.height) / 2.0
        attachment.bounds = CGRect(x: 0, y: mid + yOffset, width: size.width, height: size.height)
        return append(NSAttributedString(attachment: attachment))
    }

    @discardableResult
    public func appendImage(
        _ image: UIImage?,
        size: CGSize
    ) -> Self { appendImage(image, size: size, referenceFont: .systemFont(ofSize: 14), yOffset: 0) }

    @discardableResult
    public func appendImage(_ image: UIImage?, bounds: CGRect) -> Self {
        guard let image else {
            return self
        }
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        return append(NSAttributedString(attachment: attachment))
    }

    // MARK: - 全局属性操作

    /// 对整段添加 / 合并属性（不会清除已有局部属性）。
    @discardableResult
    public func addAttributesAll(_ attributes: [NSAttributedString.Key: Any]) -> Self {
        let range = NSRange(location: 0, length: buffer.length)
        buffer.addAttributes(attributes, range: range)
        return self
    }

    /// 覆盖整段属性（会移除已有属性再重新设置）。
    @discardableResult
    public func setAttributesAll(_ attributes: [NSAttributedString.Key: Any]) -> Self {
        let full = NSRange(location: 0, length: buffer.length)
        buffer.setAttributes(attributes, range: full)
        return self
    }

    /// - Deprecated: 请使用 `setAttributesAll(_:)`。
    @available(*, deprecated, message: "请使用 setAttributesAll(_:)。")
    @discardableResult
    public func setAttributes(_ attributes: [NSAttributedString.Key: Any]) -> Self {
        setAttributesAll(attributes)
    }

    @discardableResult
    public func addAttributesToLast(
        _ attributes: [NSAttributedString.Key: Any],
        mergeLast count: Int = 1
    ) -> Self {
        guard let targetRange = combinedLastRanges(count) else {
            return self
        }
        buffer.addAttributes(attributes, range: targetRange)
        return self
    }

    @discardableResult
    public func setAttributesToLast(
        _ attributes: [NSAttributedString.Key: Any],
        mergeLast count: Int = 1
    ) -> Self {
        guard let targetRange = combinedLastRanges(count) else {
            return self
        }
        buffer.setAttributes(attributes, range: targetRange)
        return self
    }


    @discardableResult
    public func font(_ font: UIFont, scopeAll: Bool = false) -> Self {
        applySingle(.font, value: font, scopeAll: scopeAll)
    }

    @discardableResult
    public func textColor(_ color: UIColor, scopeAll: Bool = false) -> Self {
        applySingle(.foregroundColor, value: color, scopeAll: scopeAll)
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor, scopeAll: Bool = false) -> Self {
        applySingle(.backgroundColor, value: color, scopeAll: scopeAll)
    }

    @discardableResult
    public func baselineOffset(_ offset: CGFloat, scopeAll: Bool = false) -> Self {
        applySingle(.baselineOffset, value: offset, scopeAll: scopeAll)
    }

    @discardableResult
    public func kern(_ value: CGFloat, scopeAll: Bool = false) -> Self {
        applySingle(.kern, value: value, scopeAll: scopeAll)
    }

    @discardableResult
    public func underline(
        _ style: NSUnderlineStyle = .single, color: UIColor? = nil, scopeAll: Bool = false
    ) -> Self {
        var attrs: [NSAttributedString.Key: Any] = [.underlineStyle: style.rawValue]
        if let color {
            attrs[.underlineColor] = color
        }
        return apply(attrs, scopeAll: scopeAll)
    }

    @discardableResult
    public func strikethrough(
        _ style: NSUnderlineStyle = .single,
        color: UIColor? = nil,
        scopeAll: Bool = false
    ) -> Self {
        var attrs: [NSAttributedString.Key: Any] = [.strikethroughStyle: style.rawValue]
        if let color {
            attrs[.strikethroughColor] = color
        }
        return apply(attrs, scopeAll: scopeAll)
    }

    /// 设置段落样式
    @discardableResult
    public func paragraphStyle(_ style: NSMutableParagraphStyle, scopeAll: Bool = false) -> Self {
        apply([.paragraphStyle: style], scopeAll: scopeAll)
    }

    /// 快捷设置行距
    @discardableResult
    public func lineSpacing(_ spacing: CGFloat, scopeAll: Bool = false) -> Self {
        let style: NSMutableParagraphStyle = if scopeAll,
                                                let existing = buffer.attribute(
                                                    .paragraphStyle,
                                                    at: 0,
                                                    effectiveRange: nil
                                                ) as? NSMutableParagraphStyle {
            (existing.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
        }
        else if !scopeAll,
                let lastRange,
                lastRange.length > 0,
                let existing = buffer.attribute(
                    .paragraphStyle,
                    at: lastRange.location,
                    effectiveRange: nil
                ) as? NSMutableParagraphStyle {
            (existing.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
        }
        else {
            NSMutableParagraphStyle()
        }
        style.lineSpacing = spacing
        return paragraphStyle(style, scopeAll: scopeAll)
    }

    public func build() -> NSMutableAttributedString { buildMutable() }

    /// 返回不可变副本
    public func buildImmutable() -> NSAttributedString {
        NSAttributedString(attributedString: buffer)
    }

    /// 返回可变副本（显式）
    public func buildMutable() -> NSMutableAttributedString {
        buffer.mutableCopy() as? NSMutableAttributedString ?? buffer
    }

    /// 直接暴露内部（谨慎使用，外部修改会影响 builder）。
    public var unsafeMutable: NSMutableAttributedString { buffer }

    // MARK: - Private Methods

    @discardableResult
    private func applySingle(_ key: NSAttributedString.Key, value: Any, scopeAll: Bool) -> Self {
        apply([key: value], scopeAll: scopeAll)
    }

    @discardableResult
    private func apply(_ attrs: [NSAttributedString.Key: Any], scopeAll: Bool) -> Self {
        if scopeAll {
            let full = NSRange(location: 0, length: buffer.length)
            buffer.addAttributes(attrs, range: full)
        }
        else if let targetRange = lastRange {
            buffer.addAttributes(attrs, range: targetRange)
        }
        return self
    }
}

// MARK: - NSMutableParagraphStyle then

public extension NSMutableParagraphStyle {
    @discardableResult
    func then(_ block: (NSMutableParagraphStyle) -> Void) -> Self {
        block(self)
        return self
    }
}

// swiftlint:enable opening_brace
