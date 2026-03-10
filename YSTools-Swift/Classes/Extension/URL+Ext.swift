//
//  URL+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph on 2025/8/11.
//

import Foundation

extension URL {
    /// 批量添加查询参数（支持多种值类型）
    public func appendingQueryParameters(_ parameters: [String: Any?]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        var queryItems = components.queryItems ?? []
        
        for (name, value) in parameters {
            if let value = value {
                // 将各种类型转换为字符串
                let stringValue = String(describing: value)
                queryItems.append(URLQueryItem(name: name, value: stringValue))
            }
        }
        
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        return components.url
    }
    
    /// 添加单个查询参数（支持多种值类型）
    public func appendingQueryItem(name: String, value: Any?) -> URL? {
        guard let value = value else { return self }
        return appendingQueryParameters([name: value])
    }
    
    /// 检查是否存在指定查询参数
    public func hasQueryItem(name: String) -> Bool {
        return queryParameters.keys.contains(name)
    }
    
    /// 获取指定查询参数的值
    public func queryItemValue(for name: String) -> String? {
        return queryParameters[name]
    }
    
    /// 获取所有查询参数
    public var queryParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return [:]
        }
        
        return queryItems.reduce(into: [String: String]()) { result, item in
            result[item.name] = item.value
        }
    }
    
    /// 移除指定查询参数
    public func removingQueryItem(name: String) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return self
        }
        
        components.queryItems = queryItems.filter { $0.name != name }
        return components.url
    }
}
