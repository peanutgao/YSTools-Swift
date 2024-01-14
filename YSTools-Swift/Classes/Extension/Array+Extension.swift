//
//  Array+Extension.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/9/23.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {

    public func contains(array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) {
                return false
            }
        }
        return true
    }
}
