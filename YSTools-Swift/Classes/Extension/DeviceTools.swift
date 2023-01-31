//
//  Tools.swift
//  TCDoctor
//
//  Created by Joseph Koh on 2019/4/29.
//  Copyright © 2019 Joseph Koh. All rights reserved.
//

import UIKit

// MARK: - UI
public struct Screen {
    public static let keyWindow = {
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            window =  UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            window = UIApplication.shared.keyWindow!
        }
        return window
    }()

    public static let width = Double(UIScreen.main.bounds.size.width)
    public static let height = Double(UIScreen.main.bounds.size.height)
    public static let maxLength = Double(max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
    public static let minLength = Double(min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))

    public static let tabbarHeight = 49.0
    public static let navBarHeight = (UIDevice.current.userInterfaceIdiom == .phone
                               && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) >= 812.0) ? (20.0 + 44.0 + 22.0) : (20.0 + 44.0)

    /// 高宽比
    public static let aspectRatio = Double(UIScreen.main.bounds.size.height/UIScreen.main.bounds.size.width)
    public static let layoutRatio = UIScreen.main.bounds.size.width / 375.0

    // MARK: - Device
    // pod 'DeviceGuru'
    public static let isFullScreen = (UIDevice.current.userInterfaceIdiom == .phone
        && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) >= 812.0)
}



public struct DeviceType {
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


public struct AppInfo {
    public static let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"]
    public static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    public static let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"]
}


public struct SaveArea {
    public static var bottom: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return Screen.keyWindow?.safeAreaInsets.bottom ?? 0
            } else {
                return 0
            }
        }
        set {
            
        }
        
    }
    
    public static var top: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return Screen.keyWindow?.safeAreaInsets.top ?? 0
            } else {
                return 0
            }
        }
        set {
            
        }
        
    }

}
