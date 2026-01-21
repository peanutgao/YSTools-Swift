//
//  PrettyJSONLogger.swift
//  YSTools-Swift
//
//  Created by Joseph on 2026/1/20.
//

import Foundation

// MARK: - Internal Core

private enum JSONPrettyPrinter {
    static func printJSON(
        _ object: Any,
        prefix: String? = nil
    ) {
        guard JSONSerialization.isValidJSONObject(object) else {
            debugLog("<Invalid JSON Object>\n\(object)")
            return
        }

        do {
            let data = try JSONSerialization.data(
                withJSONObject: object,
                options: writingOptions
            )

            let json = String(data: data, encoding: .utf8) ?? "<Encoding Failed>"

            if let prefix, !prefix.isEmpty {
                debugLog("\(prefix):\n\(json)")
            } else {
                debugLog(json)
            }
        } catch {
            debugLog("<JSON Error> \(error.localizedDescription)")
        }
    }

    static func jsonString(from object: Any) -> String {
        guard JSONSerialization.isValidJSONObject(object) else {
            return "<Invalid JSON Object>"
        }

        do {
            let data = try JSONSerialization.data(
                withJSONObject: object,
                options: writingOptions
            )
            return String(data: data, encoding: .utf8) ?? "<Encoding Failed>"
        } catch {
            return "<JSON Error> \(error.localizedDescription)"
        }
    }

    private static var writingOptions: JSONSerialization.WritingOptions {
        if #available(iOS 13.0, *) {
            [.prettyPrinted, .withoutEscapingSlashes]
        } else {
            [.prettyPrinted]
        }
    }
}

// MARK: - JSON Debug Wrapper

/// Wrapper type that formats JSON for debugPrint()
public struct JSONDebugWrapper: CustomDebugStringConvertible {
    let object: Any
    let prefix: String?
    
    public var debugDescription: String {
        let jsonString = JSONPrettyPrinter.jsonString(from: object)
        if let prefix = prefix, !prefix.isEmpty {
            return "\(prefix):\n\(jsonString)"
        }
        return jsonString
    }
}

// MARK: - Debug Logger

@inline(__always)
private func debugLog(_ message: @autoclosure () -> String) {
    #if DEBUG
    print(message())
    #endif
}

@inline(__always)
private func debugLogJSON(_ prefix: String? = nil, _ jsonString: @autoclosure () -> String) {
    #if DEBUG
    if let prefix = prefix, !prefix.isEmpty {
        print("\(prefix):")
    }
    print(jsonString())
    #endif
}

// MARK: - Dictionary

public extension Dictionary where Key == String {
    /// Pretty print Dictionary as JSON
    func prettyPrint(prefix: String? = nil) {
        JSONPrettyPrinter.printJSON(self, prefix: prefix)
    }

    /// Return formatted JSON string
    func prettyJSONString() -> String {
        JSONPrettyPrinter.jsonString(from: self)
    }
    
    /// Print JSON with clean output (use print instead of debugPrint)
    func printJSON(prefix: String? = nil) {
        #if DEBUG
        if let prefix = prefix, !prefix.isEmpty {
            print("\(prefix):")
        }
        print(prettyJSONString())
        #endif
    }
    
    /// Wrap as JSONDebugWrapper for use with debugPrint()
    /// Usage: debugPrint(dict.asJSONDebug())
    func asJSONDebug(prefix: String? = nil) -> JSONDebugWrapper {
        JSONDebugWrapper(object: self, prefix: prefix)
    }
}

// MARK: - Array

public extension Array {
    /// Pretty print Array as JSON
    func prettyPrint(prefix: String? = nil) {
        JSONPrettyPrinter.printJSON(self, prefix: prefix)
    }
}

// MARK: - Data

public extension Data {
    /// Pretty print JSON Data
    func prettyPrintJSON(prefix: String? = nil) {
        do {
            let object = try JSONSerialization.jsonObject(with: self)
            JSONPrettyPrinter.printJSON(object, prefix: prefix)
        } catch {
            debugLog("<Invalid JSON Data> \(error.localizedDescription)")
        }
    }
}
