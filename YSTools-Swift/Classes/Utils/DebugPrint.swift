//
//  DebugPrint.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/6/11.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

public func println(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "[yyyy/MM/dd HH:mm:ss:SSSS]:"
        let timestamp = dateFormatter.string(from: Date())
        Swift.print(timestamp, terminator: " ")
        Swift.print(items[0], separator: separator, terminator: terminator)
    #endif
}

public func printLog(_ items: Any..., separator: String = " ", file: String = #file, line: Int = #line) {
    if #available(iOS 15.0, *) {
#if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let timestamp = Date().formatted(date: .numeric, time: .standard)
        print("[\(timestamp)] [\(fileName):\(line)] \(items[0])")
#endif
    } else {
        // Fallback on earlier versions
    }
}

