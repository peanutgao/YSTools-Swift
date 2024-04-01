//
// *************************************************
// Created by Joseph Koh on 2024/1/14.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Date: 2024/1/14 14:42
// *************************************************
//

import Foundation

public extension String {
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
