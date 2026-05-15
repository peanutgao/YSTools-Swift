//
//  String+HTML.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/6.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// NSAttributedString HTML parsing internally drives WebKit/TextKit, which is
// main-thread only. Calling from a background thread raises an NSException
// that Swift `do/catch` cannot catch. Guard at the API boundary.
private func ys_assertMainThreadForHTML(_ function: StaticString = #function) -> Bool {
    if Thread.isMainThread { return true }
    #if DEBUG
    debugPrint("[YSTools] \(function) requires main thread; returning nil to avoid NSException.")
    #endif
    return false
}

public extension String {
    var html2Attributed: NSAttributedString? {
        guard ys_assertMainThreadForHTML() else { return nil }
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        } catch {
            debugPrint("error: ", error)
            return nil
        }
    }

    var htmlAttributed: (NSAttributedString?, NSDictionary?) {
        guard ys_assertMainThreadForHTML() else { return (nil, nil) }
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return (nil, nil)
            }

            var dict: NSDictionary?
            dict = NSMutableDictionary()

            return try (NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: &dict
            ), dict)
        } catch {
            debugPrint("error: ", error)
            return (nil, nil)
        }
    }

    func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString? {
        htmlAttributed(family: font.familyName, size: font.pointSize, color: color)
    }

    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        guard size > 0, size.isFinite else { return nil }
        guard ys_assertMainThreadForHTML() else { return nil }
        do {
            let escapedText = htmlEscaped
            let fontFamily = (family ?? "Helvetica").cssSingleQuotedEscaped
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString ?? "000000") !important;" +
                "font-family: '\(fontFamily)', Helvetica !important;" +
                "}</style> \(escapedText)"

            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }

            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        } catch {
            debugPrint("error: ", error)
            return nil
        }
    }

    /// Parse HTML and overlay a single font across the whole string while
    /// preserving inline colors (e.g. `<font color=#XXX>`).
    /// Returns nil when HTML parsing fails or when invoked off the main thread.
    func html2Attributed(font: UIFont) -> NSAttributedString? {
        guard let mutable = html2Attributed?.mutableCopy() as? NSMutableAttributedString else {
            return nil
        }
        mutable.addAttribute(
            .font,
            value: font,
            range: NSRange(location: 0, length: mutable.length)
        )
        return mutable
    }

    func toAttributedString(fontSize: CGFloat, lineHeight: CGFloat? = nil) -> NSAttributedString? {
        guard fontSize > 0, fontSize.isFinite else { return nil }
        let resolvedLineHeight = lineHeight ?? fontSize * 1.5
        guard resolvedLineHeight > 0, resolvedLineHeight.isFinite else { return nil }
        guard ys_assertMainThreadForHTML() else { return nil }
        let lineHeightStr = "line-height: \(resolvedLineHeight)px;"
        let escapedText = htmlEscaped

        let modifiedFontString = String(
            format: "<span style=\"font-size: \(fontSize)px; font-family: '-apple-system', 'HelveticaNeue'; \(lineHeightStr)\">%@</span>",
            escapedText
        )

        guard let data = modifiedFontString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        } catch {
            debugPrint(error)
            return nil
        }
    }
}

private extension String {
    var htmlEscaped: String {
        replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
    }

    var cssSingleQuotedEscaped: String {
        replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "'", with: "\\'")
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\r", with: " ")
    }
}

extension UIColor {
    var hexString: String? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
        // Grayscale color spaces (e.g. UIColor.white / .black created via
        // `init(white:alpha:)`) report a single luminance component.
        var w: CGFloat = 0
        if self.getWhite(&w, alpha: &a) {
            let v = Int(w * 255)
            return String(format: "%02X%02X%02X", v, v, v)
        }
        return nil
    }
}
