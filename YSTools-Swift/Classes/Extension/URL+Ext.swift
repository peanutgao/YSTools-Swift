//
//  URL+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph on 2025/8/11.
//

import Foundation

extension URL {
    public func appendingQueryParameters(_ parameters: [String: String]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }

        var queryItems = components.queryItems ?? []
        for (name, value) in parameters {
            queryItems.append(URLQueryItem(
                name: name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name,
                value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
            ))
        }
        components.queryItems = queryItems

        return components.url
    }
}
