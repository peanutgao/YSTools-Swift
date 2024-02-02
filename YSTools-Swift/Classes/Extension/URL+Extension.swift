//
//  URL+Extension.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2020/7/2.
//  Copyright © 2020 Joseph Koh. All rights reserved.
//

import UIKit

public extension URL {
    static func from(_ urlString: String?) -> URL? {
        guard let urlString else { return nil }
        return URL(string: urlString)
    }
}
