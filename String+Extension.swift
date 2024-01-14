//
//  String+Extension.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2024/1/14.
//

import Foundation

extension String {
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
