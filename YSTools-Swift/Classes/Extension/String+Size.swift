//
//  String+Size.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/5/16.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public extension String {
    func size(
        font: UIFont,
        size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    ) -> CGSize {
        self.size(attributes: [NSAttributedString.Key.font: font], size: size)
    }

    func size(
        attributes: [NSAttributedString.Key: Any]? = nil,
        size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    ) -> CGSize {
        let size = self.boundingRect(with: size,
                                     options: .usesLineFragmentOrigin,
                                     attributes: attributes,
                                     context: nil).size
        return CGSize(width: ceil(Double(size.width)), height: ceil(Double(size.height)))
    }

    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        }

        let rect = attritube.boundingRect(
            with: constrainedSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        var size = rect.size

        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing, spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }

        return size
    }

    func boundingRect(
        with constrainedSize: CGSize,
        font: UIFont, lineSpacing: CGFloat? = nil,
        lines: Int
    ) -> CGSize {
        if lines < 0 {
            return .zero
        }

        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }

        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight * CGFloat(lines) + currentLineSpacing * CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }

        return size
    }

    func isValidEmail() -> Bool {
        let emailRegex = "^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
