//
//  URL+Extension.swift
//  JDoctor
//
//  Created by Joseph Koh on 2020/7/2.
//  Copyright © 2020 Joseph Koh. All rights reserved.
//

import UIKit

public extension URL {
    
    public static func urlString(_ urlString: String?) -> URL? {
        guard let urlString = urlString else { return nil }
        return URL.init(string: urlString)
    }
}

