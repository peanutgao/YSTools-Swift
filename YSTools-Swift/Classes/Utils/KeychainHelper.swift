//
//  KeychainHelper.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation
import Security

public struct KeychainHelper {
    
    public static let standard = KeychainHelper()
    
    private init() {}
    
    /// Saves a String value to the keychain.
    /// - Parameters:
    ///   - value: The String value to save.
    ///   - service: The service name (e.g., app bundle ID).
    ///   - account: The account name (e.g., username or token key).
    /// - Returns: True if successful, false otherwise.
    @discardableResult
    public func save(_ value: String, service: String, account: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        return save(data, service: service, account: account)
    }
    
    /// Saves a Data value to the keychain.
    /// - Parameters:
    ///   - data: The Data to save.
    ///   - service: The service name.
    ///   - account: The account name.
    /// - Returns: True if successful, false otherwise.
    @discardableResult
    public func save(_ data: Data, service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        // Delete existing item
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    /// Reads a String value from the keychain.
    /// - Parameters:
    ///   - service: The service name.
    ///   - account: The account name.
    /// - Returns: The String value or nil if not found.
    public func read(service: String, account: String) -> String? {
        guard let data = readData(service: service, account: account) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Reads a Data value from the keychain.
    /// - Parameters:
    ///   - service: The service name.
    ///   - account: The account name.
    /// - Returns: The Data value or nil if not found.
    public func readData(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return dataTypeRef as? Data
        }
        return nil
    }
    
    /// Deletes a value from the keychain.
    /// - Parameters:
    ///   - service: The service name.
    ///   - account: The account name.
    /// - Returns: True if successful, false otherwise.
    @discardableResult
    public func delete(service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
    
    /// Deletes all items for a specific service.
    /// - Parameter service: The service name.
    /// - Returns: True if successful, false otherwise.
    @discardableResult
    public func deleteAll(service: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}
