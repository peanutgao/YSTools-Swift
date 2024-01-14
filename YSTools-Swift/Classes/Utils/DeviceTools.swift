//
//  Tools.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2019/4/29.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - MainScreen

public enum MainScreen {
    public struct SaveArea {
        public var top: CGFloat {
            get {
                if #available(iOS 13.0, *) {
                    let scene = UIApplication.shared.connectedScenes.first
                    guard let windowScene = scene as? UIWindowScene else {
                        return 0
                    }
                    guard let window = windowScene.windows.first else {
                        return 0
                    }
                    return window.safeAreaInsets.top
                } else {
                    guard let window = UIApplication.shared.windows.first else {
                        return 0
                    }
                    return window.safeAreaInsets.top
                }
            }
            set {}
        }

        public var bottom: CGFloat {
            get {
                if #available(iOS 13.0, *) {
                    let scene = UIApplication.shared.connectedScenes.first
                    guard let windowScene = scene as? UIWindowScene else {
                        return 0
                    }
                    guard let window = windowScene.windows.first else {
                        return 0
                    }
                    return window.safeAreaInsets.bottom
                } else {
                    guard let window = UIApplication.shared.windows.first else {
                        return 0
                    }
                    return window.safeAreaInsets.bottom
                }
            }
            set {}
        }
    }

    public static let saveArea = SaveArea()
    public static let keyWindow = {
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .filter(\.isKeyWindow).first
        } else {
            window = UIApplication.shared.keyWindow!
        }
        return window
    }()

    public static var statusBarHeight: CGFloat {
        get {
            var statusBarHeight: CGFloat = 0
            if #available(iOS 13.0, *) {
                let scene = UIApplication.shared.connectedScenes.first
                guard let windowScene = scene as? UIWindowScene else {
                    return 0
                }
                guard let statusBarManager = windowScene.statusBarManager else {
                    return 0
                }
                statusBarHeight = statusBarManager.statusBarFrame.height
            } else {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
            return statusBarHeight
        }
        set {}
    }

    public static let navigationBarHeight: CGFloat = 44.0
    /// tatusBar height + top SaveArea + navigation bar height
    public static var navigationMaxY: CGFloat {
        get {
            statusBarHeight + navigationBarHeight
        }
        set {}
    }

    public static let tabBarHeight: CGFloat = 49.0
    public static var tabBarHeightWithSaveArea: CGFloat {
        get {
            tabBarHeight + saveArea.bottom
        }
        set {}
    }

    public static let width = Double(UIScreen.main.bounds.size.width)
    public static let height = Double(UIScreen.main.bounds.size.height)
    public static let maxLength = Double(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
    public static let minLength = Double(min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))

    /// 屏幕长宽比
    public static let aspectRatio = Double(UIScreen.main.bounds.size.height / UIScreen.main.bounds.size.width)
    ///
    public static let designScale = UIScreen.main.bounds.size.width / 375.0

    // MARK: - Device

    ///
    public static var hasNotch: Bool {
        get {
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.windows.first
                let topInset = window?.safeAreaInsets.top ?? 0
                return topInset > 20
            } else {
                return false
            }
        }
        set {}
    }
}

// MARK: - DeviceType

public enum DeviceType {
    public static let is_iPhone = (UIDevice.current.userInterfaceIdiom == .phone)
    public static let is_iPad = (UIDevice.current.userInterfaceIdiom == .pad)

    public static let is_iPhone_5 = (UIDevice.current.userInterfaceIdiom == .phone
        && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0)
    public static let is_iPhone_6_7_8 = (UIDevice.current.userInterfaceIdiom == .phone
        && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 667.0)
    public static let is_iPhone_PLUS = (UIDevice.current.userInterfaceIdiom == .phone
        && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 736.0)
    public static let is_iPhone_X_XS = (UIDevice.current.userInterfaceIdiom == .phone
        && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 812.0)
    public static let is_iPhone_XR = (UIDevice.current.userInterfaceIdiom == .phone
        && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 896.0)
    public static let is_iPhone_XS_MAX = (UIDevice.current.userInterfaceIdiom == .phone
        && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 896.0)
}

// MARK: - AppInfo

public enum AppInfo {
    public static let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"]
    public static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    public static let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"]
}
