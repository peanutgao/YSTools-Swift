//
//  PermissionHelper.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation
import AVFoundation
import Photos
import CoreLocation
import UserNotifications

public class PermissionHelper: NSObject {
    
    public enum PermissionType {
        case camera
        case photoLibrary
        case microphone
        case locationWhenInUse
        case locationAlways
        case notification
    }
    
    public enum Status {
        case authorized
        case denied
        case notDetermined
        case restricted
        case unknown
    }
    
    /// Checks the current status of a permission.
    /// - Parameter type: The permission type.
    /// - Returns: The current status.
    public static func checkStatus(for type: PermissionType) -> Status {
        switch type {
        case .camera:
            return convertAVStatus(AVCaptureDevice.authorizationStatus(for: .video))
        case .photoLibrary:
            return convertPhotoStatus(PHPhotoLibrary.authorizationStatus())
        case .microphone:
            return convertAVStatus(AVCaptureDevice.authorizationStatus(for: .audio))
        case .locationWhenInUse, .locationAlways:
            return convertLocationStatus(CLLocationManager.authorizationStatus())
        case .notification:
            // Notification status is async, so we return unknown here or handle differently.
            // For synchronous check, it's not possible.
            return .unknown
        }
    }
    
    /// Requests permission for the specified type.
    /// - Parameters:
    ///   - type: The permission type.
    ///   - completion: Closure called with the success status.
    public static func request(for type: PermissionType, completion: @escaping (Bool) -> Void) {
        switch type {
        case .camera:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
        case .photoLibrary:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async { completion(status == .authorized || status == .limited) }
            }
        case .microphone:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
        case .locationWhenInUse:
            // Location request requires an instance delegate, which is complex for a static helper.
            // This is a simplified placeholder. In real apps, use a CLLocationManager instance.
            print("Location permission request requires CLLocationManager instance handling.")
            completion(false)
        case .locationAlways:
            print("Location permission request requires CLLocationManager instance handling.")
            completion(false)
        case .notification:
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                DispatchQueue.main.async { completion(granted) }
            }
        }
    }
    
    // MARK: - Converters
    
    private static func convertAVStatus(_ status: AVAuthorizationStatus) -> Status {
        switch status {
        case .authorized: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .unknown
        }
    }
    
    private static func convertPhotoStatus(_ status: PHAuthorizationStatus) -> Status {
        switch status {
        case .authorized, .limited: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .unknown
        }
    }
    
    private static func convertLocationStatus(_ status: CLAuthorizationStatus) -> Status {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .unknown
        }
    }
}
