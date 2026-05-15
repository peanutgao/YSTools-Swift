//
//  PermissionHelper.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import AVFoundation
import CoreLocation
import Foundation
import Photos
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
            convertAVStatus(AVCaptureDevice.authorizationStatus(for: .video))
        case .photoLibrary:
            convertPhotoStatus(PHPhotoLibrary.authorizationStatus())
        case .microphone:
            convertAVStatus(AVCaptureDevice.authorizationStatus(for: .audio))
        case .locationWhenInUse,
             .locationAlways:
            if #available(iOS 14.0, *) {
                convertLocationStatus(CLLocationManager().authorizationStatus)
            } else {
                convertLocationStatus(CLLocationManager.authorizationStatus())
            }
        case .notification:
            // Notification status is async, so we return unknown here or handle differently.
            // For synchronous check, it's not possible.
            .unknown
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
                DispatchQueue.main.async {
                    if #available(iOS 14, *) {
                        completion(status == .authorized || status == .limited)
                    } else {
                        completion(status == .authorized)
                    }
                }
            }

        case .microphone:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async { completion(granted) }
            }

        case .locationWhenInUse, .locationAlways:
            // Location requires CLLocationManager instance + delegate. Use
            // `requestLocation(_:type:)` with a managed instance instead.
            // Reported as failure on the main thread to keep callback contract
            // consistent with the other branches.
            #if DEBUG
            debugPrint("[YSTools] Use PermissionHelper.requestLocation(_:type:) with a caller-owned CLLocationManager for location permission requests.")
            #endif
            DispatchQueue.main.async { completion(false) }

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
        case .authorized,
             .limited: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .unknown
        }
    }

    private static func convertLocationStatus(_ status: CLAuthorizationStatus) -> Status {
        switch status {
        case .authorizedAlways,
             .authorizedWhenInUse: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        @unknown default: return .unknown
        }
    }
}

// MARK: - Location with explicit manager

public extension PermissionHelper {
    /// Request location authorization through a caller-provided CLLocationManager.
    /// Caller owns the manager (it must outlive the request) and the delegate
    /// already wired to capture the response.
    static func requestLocation(_ manager: CLLocationManager, type: PermissionType) {
        switch type {
        case .locationWhenInUse:
            manager.requestWhenInUseAuthorization()
        case .locationAlways:
            manager.requestAlwaysAuthorization()
        default:
            #if DEBUG
            debugPrint("[YSTools] PermissionHelper.requestLocation called with non-location type: \(type)")
            #endif
        }
    }
}
