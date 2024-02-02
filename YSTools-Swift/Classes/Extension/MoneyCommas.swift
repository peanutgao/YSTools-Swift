//
// *************************************************
// Created by Joseph Koh on 2023/11/25.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2023/11/25 23:49
// *************************************************
//

import Foundation

extension Int {
    func formattedWithThousandSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }

    static func formattedWithThousandSeparator(value: Int?) -> String? {
        guard let value else {
            return nil
        }

        return value.formattedWithThousandSeparator()
    }
}

extension String {
    func formattedWithThousandSeparator() -> String {
        guard let intValue = Int(self) else {
            return self
        }
        return intValue.formattedWithThousandSeparator()
    }

    static func formattedWithThousandSeparator(value: String?) -> String? {
        guard let value else {
            return nil
        }

        return value.formattedWithThousandSeparator()
    }
}
