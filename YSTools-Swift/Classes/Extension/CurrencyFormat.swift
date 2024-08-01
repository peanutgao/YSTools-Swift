//
// *************************************************
// Created by Joseph Koh on 2023/11/25.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2023/11/25 23:49
// *************************************************
//

import Foundation

public extension Int {
    var asThousandSeparatedString: String {
        return formatAsThousandSeparated()
    }

    func formatAsThousandSeparated(separator: String = ",") -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = separator
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }

    static func formatAsThousandSeparated(value: Int?, separator: String = ",") -> String? {
        guard let value = value else {
            return nil
        }
        return value.formatAsThousandSeparated(separator: separator)
    }
}

public extension String {
    var asThousandSeparatedString: String {
        return formatAsThousandSeparated()
    }

    func formatAsThousandSeparated(separator: String = ",") -> String {
        guard let intValue = Int(self) else {
            return self
        }
        return intValue.formatAsThousandSeparated(separator: separator)
    }

    static func formatAsThousandSeparated(value: String?, separator: String = ",") -> String? {
        guard let value = value else {
            return nil
        }
        return value.formatAsThousandSeparated(separator: separator)
    }
}
