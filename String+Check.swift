//
// *************************************************
// Created by Joseph Koh on 2024/1/14.
// Author: Joseph Koh
// Email: Joseph0750@gmail.com
// Create Time: 2024/1/14 14:42
// *************************************************
//

import Foundation

extension String {
    public var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}