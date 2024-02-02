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
        var window: UIWindow? = if #available(iOS 13.0, *) {
            UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .filter(\.isKeyWindow).first
        } else {
            UIApplication.shared.keyWindow!
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

// MARK: - AppInfo

public enum AppInfo {
    public static let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"]
    public static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    public static let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"]
}

// MARK: - DeviceInfo

public class DeviceInfo {
    public static let shared = DeviceInfo()

    public let model: String = UIDevice.current.model

    private var _CPU: String?
    public var CPU: String {
        if _CPU != nil {
            return _CPU!
        }
        _CPU = DeviceType.deviceCPUList[machineName] ?? "Unknown"
        return _CPU!
    }

    public let RAM = "\(ProcessInfo.processInfo.physicalMemory)"

    private var _ROM: String?
    public var ROM: String? {
        if _ROM != nil {
            return _ROM!
        }
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last,
           let attributes = try? fileManager.attributesOfFileSystem(forPath: documentDirectory.path),
           let totalSpace = attributes[.systemSize] as? NSNumber
        {
            _ROM = "\(totalSpace)"
            return _ROM
        }
        return nil
    }

    public var memoryUsage: String {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4

        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }

        if kerr == KERN_SUCCESS {
            let usedMemory = info.resident_size
//            let totalMemory = ProcessInfo.processInfo.physicalMemory
//            let usedMemoryMB = usedMemory / 1024 / 1024
//            let totalMemoryMB = totalMemory / 1024 / 1024
//            let memoryUsage = Double(usedMemory) / Double(totalMemory) * 100
            return "\(usedMemory)"
        } else {
            return "unknown"
        }
    }

    public var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    private var _machineName: String?
    public var machineName: String {
        if _machineName != nil {
            return _machineName!
        }

        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            _machineName = identifier + String(UnicodeScalar(UInt8(value)))
            return _machineName ?? identifier
        }
        return identifier
    }

    private var _commercialName: String?
    public var commercialName: String {
        if _commercialName != nil {
            return _commercialName!
        }
        _commercialName = DeviceType.commercialName(for: machineName)
        return _commercialName!
    }

    public var resolution: String? {
        guard let size = UIApplication.shared.windows.first?.frame.size else {
            return nil
        }
        return "\(size.width)x\(size.height)"
    }

    private var _isJailBroken: Bool?
    public var isJailBroken: Bool {
        if let _isJailBroken {
            return _isJailBroken
        }
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") ||
            FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            FileManager.default.fileExists(atPath: "/bin/bash") ||
            FileManager.default.fileExists(atPath: "/usr/sbin/sshd") ||
            FileManager.default.fileExists(atPath: "/etc/apt") ||
            FileManager.default.fileExists(atPath: "/private/var/lib/apt/") ||
            UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!)
        {
            _isJailBroken = true
            return true
        }

//        if canWriteOutsideOfSandbox() {
//            _isJailBroken = true
//            return true
//        }

        let file = fopen("/bin/bash", "r")
        if file != nil {
            fclose(file)
            _isJailBroken = true
            return true
        }

        _isJailBroken = false
        return false
    }

    private var _buildTime: String?
    public var buildTime: String {
        if let _buildTime {
            return _buildTime
        }
        _buildTime = "\(getSystemBuildTime())"
        return _buildTime!
    }

    private var _bootTimeInterval: String?
    public var bootTimeInterval: String {
        if let _bootTimeInterval {
            return _bootTimeInterval
        }
        _bootTimeInterval = getDeviceBootTime()
        return _bootTimeInterval!
    }

    private init() {}
}

private extension DeviceInfo {
    func canWriteOutsideOfSandbox() -> Bool {
        let path = "/private/" + NSUUID().uuidString
        do {
            try "test".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }

    func getSystemBuildTime() -> Int64 {
        let processInfo = ProcessInfo()
        let systemUptime = processInfo.systemUptime
        let bootTime = Date(timeIntervalSinceNow: -systemUptime)
        return Int64(bootTime.timeIntervalSince1970 * 1000)
    }

    func getDeviceBootTime() -> String {
        var boottime = timeval()
        var mib: [Int32] = [CTL_KERN, KERN_BOOTTIME]
        var size = MemoryLayout<timeval>.stride

        var now = timeval()
        gettimeofday(&now, nil)

        let result = sysctl(&mib, u_int(mib.count), &boottime, &size, nil, 0)
        if result != -1, boottime.tv_sec != 0 {
            let uptimeSeconds = now.tv_sec - boottime.tv_sec
            return "\(uptimeSeconds)"
        } else {
            return "\(TimeInterval(-1))"
        }
    }
}

// MARK: - DeviceType

public enum DeviceType {
    public static let deviceList: [String: String] = [
        // iPhone
        "iPhone1,1": "iPhone",
        "iPhone1,2": "iPhone 3G",
        "iPhone2,1": "iPhone 3GS",
        "iPhone3,1": "iPhone 4",
        "iPhone3,2": "iPhone 4",
        "iPhone3,3": "iPhone 4",
        "iPhone4,1": "iPhone 4S",
        "iPhone5,1": "iPhone 5",
        "iPhone5,2": "iPhone 5",
        "iPhone5,3": "iPhone 5c",
        "iPhone5,4": "iPhone 5c",
        "iPhone6,1": "iPhone 5s",
        "iPhone6,2": "iPhone 5s",
        "iPhone7,2": "iPhone 6",
        "iPhone7,1": "iPhone 6 Plus",
        "iPhone8,1": "iPhone 6s",
        "iPhone8,2": "iPhone 6s Plus",
        "iPhone8,4": "iPhone SE (1st generation)",
        "iPhone9,1": "iPhone 7",
        "iPhone9,3": "iPhone 7",
        "iPhone9,2": "iPhone 7 Plus",
        "iPhone9,4": "iPhone 7 Plus",
        "iPhone10,1": "iPhone 8",
        "iPhone10,4": "iPhone 8",
        "iPhone10,2": "iPhone 8 Plus",
        "iPhone10,5": "iPhone 8 Plus",
        "iPhone10,3": "iPhone X",
        "iPhone10,6": "iPhone X",
        "iPhone11,8": "iPhone XR",
        "iPhone11,2": "iPhone XS",
        "iPhone11,6": "iPhone XS Max",
        "iPhone11,4": "iPhone XS Max",
        "iPhone12,1": "iPhone 11",
        "iPhone12,3": "iPhone 11 Pro",
        "iPhone12,5": "iPhone 11 Pro Max",
        "iPhone12,8": "iPhone SE (2nd generation)",
        "iPhone13,1": "iPhone 12 mini",
        "iPhone13,2": "iPhone 12",
        "iPhone13,3": "iPhone 12 Pro",
        "iPhone13,4": "iPhone 12 Pro Max",
        "iPhone14,4": "iPhone 13 mini",
        "iPhone14,5": "iPhone 13",
        "iPhone14,2": "iPhone 13 Pro",
        "iPhone14,3": "iPhone 13 Pro Max",
        "iPhone14,6": "iPhone SE (3rd generation)",
        "iPhone14,7": "iPhone 14",
        "iPhone14,8": "iPhone 14 Plus",
        "iPhone15,2": "iPhone 14 Pro",
        "iPhone15,3": "iPhone 14 Pro Max",

        "iPhone15,4": "iPhone 15",
        "iPhone15,5": "iPhone 15 Plus",
        "iPhone16,1": "iPhone 15 Pro",
        "iPhone16,2": "iPhone 15 Pro Max",

        // iPod
        "iPod3,1": "iPod touch (3rd generation)",
        "iPod4,1": "iPod touch (4th generation)",
        "iPod5,1": "iPod touch (5th generation)",
        "iPod7,1": "iPod touch (6th generation)",
        "iPod9,1": "iPod touch (7th generation)",

        // iPad
        "iPad1,1": "iPad",
        "iPad2,1": "iPad 2",
        "iPad2,2": "iPad 2",
        "iPad2,3": "iPad 2",
        "iPad2,4": "iPad 2",
        "iPad3,1": "iPad (3rd generation)",
        "iPad3,2": "iPad (3rd generation)",
        "iPad3,3": "iPad (3rd generation)",
        "iPad3,4": "iPad (4th generation)",
        "iPad3,5": "iPad (4th generation)",
        "iPad3,6": "iPad (4th generation)",
        "iPad6,11": "iPad (5th generation)",
        "iPad6,12": "iPad (5th generation)",
        "iPad7,5": "iPad (6th generation)",
        "iPad7,6": "iPad (6th generation)",
        "iPad7,11": "iPad (7th generation)",
        "iPad7,12": "iPad (7th generation)",
        // iPad Air
        "iPad4,1": "iPad Air",
        "iPad4,2": "iPad Air",
        "iPad4,3": "iPad Air",
        "iPad5,3": "iPad Air 2",
        "iPad5,4": "iPad Air 2",
        "iPad11,3": "iPad Air (3rd generation)",
        "iPad11,4": "iPad Air (3rd generation)",
        // iPad Pro
        "iPad6,7": "iPad Pro (12.9-inch)",
        "iPad6,8": "iPad Pro (12.9-inch)",
        "iPad6,3": "iPad Pro (9.7-inch)",
        "iPad6,4": "iPad Pro (9.7-inch)",
        "iPad7,1": "iPad Pro (12.9-inch) (2nd generation)",
        "iPad7,2": "iPad Pro (12.9-inch) (2nd generation)",
        "iPad7,3": "iPad Pro (10.5-inch)",
        "iPad7,4": "iPad Pro (10.5-inch)",
        "iPad8,1": "iPad Pro (11-inch)",
        "iPad8,2": "iPad Pro (11-inch)",
        "iPad8,3": "iPad Pro (11-inch)",
        "iPad8,4": "iPad Pro (11-inch)",
        "iPad8,5": "iPad Pro (12.9-inch) (3rd generation)",
        "iPad8,6": "iPad Pro (12.9-inch) (3rd generation)",
        "iPad8,7": "iPad Pro (12.9-inch) (3rd generation)",
        "iPad8,8": "iPad Pro (12.9-inch) (3rd generation)",
        "iPad8,9": "iPad Pro (11-inch) (2nd generation)",
        "iPad8,10": "iPad Pro (11-inch) (2nd generation)",
        "iPad8,11": "iPad Pro (12.9-inch) (4th generation)",
        "iPad8,12": "iPad Pro (12.9-inch) (4th generation)",

        // iPad mini
        "iPad2,5": "iPad mini",
        "iPad2,6": "iPad mini",
        "iPad2,7": "iPad mini",
        "iPad4,4": "iPad mini 2",
        "iPad4,5": "iPad mini 2",
        "iPad4,6": "iPad mini 2",
        "iPad4,7": "iPad mini 3",
        "iPad4,8": "iPad mini 3",
        "iPad4,9": "iPad mini 3",
        "iPad5,1": "iPad mini 4",
        "iPad5,2": "iPad mini 4",
        "iPad11,1": "iPad mini (5th generation)",
        "iPad11,2": "iPad mini (5th generation)",
        // other
        "i386": "iPhone Simulator",
        "x86_64": "iPhone Simulator",
    ]

    public static func commercialName(for identifier: String) -> String {
        deviceList[identifier] ?? identifier
    }

    public static let deviceCPUList: [String: String] = [
        "iPhone4,1": "Apple A5",
        "iPhone5,1": "Apple A6",
        "iPhone5,2": "Apple A6",
        "iPhone5,3": "Apple A6",
        "iPhone5,4": "Apple A6",
        "iPhone6,1": "Apple A7",
        "iPhone6,2": "Apple A7",
        "iPhone7,2": "Apple A8",
        "iPhone7,1": "Apple A8",
        "iPhone8,1": "Apple A9",
        "iPhone8,2": "Apple A9",
        "iPhone8,4": "Apple A9",
        "iPhone9,1": "Apple A10 Fusion",
        "iPhone9,3": "Apple A10 Fusion",
        "iPhone9,2": "Apple A10 Fusion",
        "iPhone9,4": "Apple A10 Fusion",
        "iPhone10,1": "Apple A11 Bionic",
        "iPhone10,4": "Apple A11 Bionic",
        "iPhone10,2": "Apple A11 Bionic",
        "iPhone10,5": "Apple A11 Bionic",
        "iPhone10,3": "Apple A11 Bionic",
        "iPhone10,6": "Apple A11 Bionic",
        "iPhone11,8": "Apple A12 Bionic",
        "iPhone11,2": "Apple A12 Bionic",
        "iPhone11,4": "Apple A12 Bionic",
        "iPhone11,6": "Apple A12 Bionic",
        "iPhone12,1": "Apple A13 Bionic",
        "iPhone12,3": "Apple A13 Bionic",
        "iPhone12,5": "Apple A13 Bionic",
        "iPhone12,8": "Apple A13 Bionic",
        "iPhone13,1": "Apple A14 Bionic",
        "iPhone13,2": "Apple A14 Bionic",
        "iPhone13,3": "Apple A14 Bionic",
        "iPhone13,4": "Apple A14 Bionic",
        "iPhone14,4": "Apple A15 Bionic",
        "iPhone14,5": "Apple A15 Bionic",
        "iPhone14,2": "Apple A15 Bionic",
        "iPhone14,3": "Apple A15 Bionic",
        "iPhone14,7": "Apple A15 Bionic",
        "iPhone14,8": "Apple A15 Bionic",
        "iPhone15,2": "Apple A16 Bionic",
        "iPhone15,3": "Apple A16 Bionic",

        "iPhone15,4": "Apple A16",
        "iPhone15,5": "Apple A16",
        "iPhone16,1": "Apple A17 Pro",
        "iPhone16,2": "Apple A17 Pro",

        // iPad
        "iPad4,1": "Apple A7",
        "iPad4,2": "Apple A7",
        "iPad4,3": "Apple A7",
        "iPad5,3": "Apple A8X",
        "iPad5,4": "Apple A8X",
        "iPad6,7": "Apple A9X",
        "iPad6,8": "Apple A9X",
        "iPad6,11": "Apple A9",
        "iPad6,12": "Apple A9",
        "iPad7,5": "Apple A10 Fusion",
        "iPad7,6": "Apple A10 Fusion",
        "iPad8,1": "Apple A12X Bionic",
        "iPad8,2": "Apple A12X Bionic",
        "iPad8,3": "Apple A12X Bionic",
        "iPad8,4": "Apple A12X Bionic",
        "iPad8,5": "Apple A12X Bionic",
        "iPad8,6": "Apple A12X Bionic",
        "iPad8,7": "Apple A12X Bionic",
        "iPad8,8": "Apple A12X Bionic",
        "iPad11,1": "Apple A12 Bionic",
        "iPad11,2": "Apple A12 Bionic",
        "iPad11,3": "Apple A12 Bionic",
        "iPad11,4": "Apple A12 Bionic",
        // iPod
        "iPod2,1": "S5L8750",
        "iPod3,1": "S5L8922",
        "iPod4,1": "Apple A4",
        "iPod5,1": "Apple A5",
        "iPod7,1": "Apple A8",
        "iPod9,1": "Apple A10 Fusion",
    ]
}
