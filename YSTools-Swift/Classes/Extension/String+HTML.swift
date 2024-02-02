//
//  String+HTML.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/6.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension String {
    var html2Attributed: NSAttributedString? {
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
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
                "}</style> \(self)"

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

    func convertHTMLStringToNSAttributedString(fontSize: CGFloat) -> NSAttributedString? {
        let modifiedFontString = String(
            format: "<span style=\"font-size: \(fontSize)px; font-family: '-apple-system', 'HelveticaNeue';\">%@</span>",
            self
        )

        guard let data = modifiedFontString.data(using: String.Encoding.utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue,
        ]

        do {
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        } catch {
            debugPrint(error)
            return nil
        }
    }
}

extension UIColor {
    var hexString: String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
        return nil
    }
}
