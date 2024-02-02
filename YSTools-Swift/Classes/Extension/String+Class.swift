//
//  String+Class.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/4/29.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

extension String {
    /// Covert string to Class
    /// usage:
    /// if let myClass = "MyAppName.MyClassName".toClass() {
    ///         debugPrint(myClass)
    /// } else {
    /// }
    /// - Returns: class
    func toClass() -> AnyClass? {
        NSClassFromString(self)
    }
}

// MARK: - ClassConverter

enum ClassConverter {
    /// 根据给定的类名字符串和模块名返回对应的类。
    /// - Parameters:
    ///   - className: 类名的字符串表示。
    ///   - moduleName: 包含类定义的模块名。
    /// - Returns: 如果找到对应的类，则返回该类；否则返回nil。
    static func classFromString(_ className: String, inModuleName moduleName: String? = nil) -> AnyClass? {
        if let moduleName {
            let fullClassName = "\(moduleName).\(className)"
            return NSClassFromString(fullClassName)
        } else {
            return NSClassFromString(className)
        }
    }
}
