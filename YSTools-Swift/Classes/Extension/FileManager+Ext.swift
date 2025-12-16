//
//  FileManager+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation

public extension FileManager {
    
    /// Returns the URL for the Documents directory.
    static var documentsDirectory: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    /// Returns the URL for the Caches directory.
    static var cachesDirectory: URL {
        return `default`.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    /// Returns the URL for the Temporary directory.
    static var tempDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    /// Checks if a file exists at the given URL.
    /// - Parameter url: The file URL.
    /// - Returns: True if exists, false otherwise.
    static func fileExists(at url: URL) -> Bool {
        return `default`.fileExists(atPath: url.path)
    }
    
    /// Removes a file at the given URL if it exists.
    /// - Parameter url: The file URL.
    static func removeFile(at url: URL) {
        guard fileExists(at: url) else { return }
        do {
            try `default`.removeItem(at: url)
        } catch {
            print("Error removing file at \(url): \(error)")
        }
    }
    
    /// Saves data to a file at the specified URL.
    /// - Parameters:
    ///   - data: The data to save.
    ///   - url: The destination URL.
    /// - Returns: True if successful, false otherwise.
    @discardableResult
    static func save(_ data: Data, to url: URL) -> Bool {
        do {
            try data.write(to: url, options: .atomic)
            return true
        } catch {
            print("Error saving file to \(url): \(error)")
            return false
        }
    }
    
    /// Creates a directory if it doesn't exist.
    /// - Parameter url: The directory URL.
    static func createDirectory(at url: URL) {
        guard !fileExists(at: url) else { return }
        do {
            try `default`.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating directory at \(url): \(error)")
        }
    }
    
    /// Returns the file size in bytes.
    /// - Parameter url: The file URL.
    /// - Returns: The size in bytes, or 0 if failed.
    static func fileSize(at url: URL) -> UInt64 {
        guard fileExists(at: url) else { return 0 }
        do {
            let attributes = try `default`.attributesOfItem(atPath: url.path)
            return attributes[.size] as? UInt64 ?? 0
        } catch {
            return 0
        }
    }
}
