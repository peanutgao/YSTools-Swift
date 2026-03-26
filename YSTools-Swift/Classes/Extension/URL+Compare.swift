//
//  URL+Compare.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/3/26.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import Foundation

public extension String {
    var toUrl: URL? {
        // Trim accidental leading/trailing spaces before URL parsing.
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return nil
        }

        return URL(string: trimmed)
    }
}

public extension Optional where Wrapped == String {
    var toUrl: URL? {
        flatMap { $0.toUrl }
    }
}

public extension URL {
    func isSameURL(_ other: URL?) -> Bool {
        guard let other else {
            return false
        }

        if self == other {
            return true
        }

        // Compare canonicalized URL components to avoid false negatives caused by
        // casing differences, default ports, query order, or empty paths.
        return canonicalComparableComponents == other.canonicalComparableComponents
    }

    private var canonicalComparableComponents: CanonicalURLComponents {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return CanonicalURLComponents(fallback: absoluteString)
        }

        components.scheme = components.scheme?.lowercased()
        components.host = components.host?.lowercased()

        // Fragment does not affect resource identity for network requests.
        components.fragment = nil

        // Normalize default ports so "https://a.com" equals "https://a.com:443".
        if let scheme = components.scheme, let port = components.port, isDefaultPort(port, for: scheme) {
            components.port = nil
        }

        // For hierarchical URLs, an empty path is effectively root.
        if components.path.isEmpty, let scheme = components.scheme, ["http", "https"].contains(scheme) {
            components.path = "/"
        }

        if let queryItems = components.queryItems, !queryItems.isEmpty {
            components.queryItems = queryItems.sorted {
                if $0.name != $1.name {
                    return $0.name < $1.name
                }
                return ($0.value ?? "") < ($1.value ?? "")
            }
        }

        return CanonicalURLComponents(
            scheme: components.scheme,
            host: components.host,
            port: components.port,
            user: components.user,
            password: components.password,
            path: components.path,
            queryItems: components.queryItems,
            rawFallback: nil
        )
    }

    private func isDefaultPort(_ port: Int, for scheme: String) -> Bool {
        switch scheme {
        case "http":
            return port == 80
        case "https":
            return port == 443
        default:
            return false
        }
    }
}

private struct CanonicalURLComponents: Equatable {
    let scheme: String?
    let host: String?
    let port: Int?
    let user: String?
    let password: String?
    let path: String
    let queryItems: [URLQueryItem]?
    let rawFallback: String?

    init(
        scheme: String?,
        host: String?,
        port: Int?,
        user: String?,
        password: String?,
        path: String,
        queryItems: [URLQueryItem]?,
        rawFallback: String?
    ) {
        self.scheme = scheme
        self.host = host
        self.port = port
        self.user = user
        self.password = password
        self.path = path
        self.queryItems = queryItems
        self.rawFallback = rawFallback
    }

    init(fallback: String) {
        self.init(
            scheme: nil,
            host: nil,
            port: nil,
            user: nil,
            password: nil,
            path: "",
            queryItems: nil,
            rawFallback: fallback
        )
    }

    static func == (lhs: CanonicalURLComponents, rhs: CanonicalURLComponents) -> Bool {
        switch (lhs.rawFallback, rhs.rawFallback) {
        case let (left?, right?):
            return left == right
        case (nil, nil):
            return lhs.scheme == rhs.scheme
                && lhs.host == rhs.host
                && lhs.port == rhs.port
                && lhs.user == rhs.user
                && lhs.password == rhs.password
                && lhs.path == rhs.path
                && lhs.queryItems == rhs.queryItems
        default:
            return false
        }
    }
}

public extension Optional where Wrapped == URL {
    func isSameURL(_ other: URL?) -> Bool {
        guard let self else {
            return false
        }

        return self.isSameURL(other)
    }
}
