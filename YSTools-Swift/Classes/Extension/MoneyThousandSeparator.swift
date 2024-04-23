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
    var thousandSeparatorString: String {
        formattedWithThousandSeparator()
    }

    var pointThousandSeparatorString: String {
        formattedWithThousandSeparator(separator: ".")
    }
    
    func formattedWithThousandSeparator(separator: String = ",") -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = separator
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }

    static func formattedWithThousandSeparator(value: Int?) -> String? {
        guard let value else {
            return nil
        }
        return value.formattedWithThousandSeparator()
    }
}

public extension String {

    var thousandSeparatorString: String {
        formattedWithThousandSeparator()
    }
    
    var pointThousandSeparatorString: String {
        formattedWithThousandSeparator(separator: ".")
    }

    func formattedWithThousandSeparator(separator: String = ",") -> String {
        guard let intValue = Int(self) else {
            return self
        }
        return intValue.formattedWithThousandSeparator(separator: separator)
    }

    static func formattedWithThousandSeparator(value: String?, separator: String = ",") -> String? {
        guard let value else {
            return nil
        }

        return value.formattedWithThousandSeparator(separator: separator)
    }
}
