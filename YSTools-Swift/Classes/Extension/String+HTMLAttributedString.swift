//
// *************************************************
// Created by Joseph Koh on 2023/11/24.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2023/11/24 23:36
// *************************************************
//

import Foundation

extension String {
    func convertHTMLStringToNSAttributedString(fontSize: CGFloat) -> NSAttributedString? {
        let modifiedFontString = String(format: "<span style=\"font-size: \(fontSize)px; font-family: '-apple-system', 'HelveticaNeue';\">%@</span>", self)

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
