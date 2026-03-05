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

    public static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .filter(\.isKeyWindow).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }

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
        if let cached = _CPU {
            return cached
        }
        let result = DeviceType.deviceCPUList[machineName] ?? "Unknown"
        _CPU = result
        return result
    }

    public let RAM: UInt64 = ProcessInfo.processInfo.physicalMemory

    private var _ROM: UInt64?
    public var ROM: UInt64? {
        if let cached = _ROM {
            return cached
        }
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last,
           let attributes = try? fileManager.attributesOfFileSystem(forPath: documentDirectory.path),
           let totalSpace = attributes[.systemSize] as? UInt64 {
            _ROM = totalSpace
            return totalSpace
        }
        return nil
    }

    public var memoryUsage: UInt64? {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4

        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }

        if kerr == KERN_SUCCESS {
            return info.resident_size
//            let totalMemory = ProcessInfo.processInfo.physicalMemory
//            let usedMemoryMB = usedMemory / 1024 / 1024
//            let totalMemoryMB = totalMemory / 1024 / 1024
//            let memoryUsage = Double(usedMemory) / Double(totalMemory) * 100
        } else {
            return nil
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
        if let cached = _machineName {
            return cached
        }

        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let result = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        _machineName = result
        return result
    }

    private var _commercialName: String?
    public var commercialName: String {
        if let cached = _commercialName {
            return cached
        }
        let result = DeviceType.commercialName(for: machineName)
        _commercialName = result
        return result
    }

    public var resolution: String? {
        let size = UIScreen.main.bounds
        return "\(size.width)x\(size.height)"
    }

    private var _isJailBroken: Bool?
    private var _detectionCache: [String: Bool] = [:]
    private let detectionQueue = DispatchQueue(label: "com.ystools.jailbreak.detection", qos: .userInitiated)

    private func detectionSync<T>(_ work: () -> T) -> T {
        detectionQueue.sync(execute: work)
    }

    public var isJailBroken: Bool {
        if let cachedResult = detectionSync({ _isJailBroken }) {
            return cachedResult
        }

        #if targetEnvironment(simulator)
            detectionSync {
                _isJailBroken = false
            }
            return false
        #else
        if getCachedOrCompute("jailbreakFiles", compute: isContainsJailbrokenFiles) {
            detectionSync {
                _isJailBroken = true
            }
            return true
        }
        if getCachedOrCompute("bashAccess", compute: checkBashAccess) {
            detectionSync {
                _isJailBroken = true
            }
            return true
        }
        if getCachedOrCompute("dylibInjection", compute: checkDylibInjection) {
            detectionSync {
                _isJailBroken = true
            }
            return true
        }
        if getCachedOrCompute("sandboxEscape", compute: canWriteOutsideOfSandbox) {
            detectionSync {
                _isJailBroken = true
            }
            return true
        }
        detectionSync {
            _isJailBroken = false
        }
        return false
        #endif
    }

    /// Helper to get cached result or compute and cache
    private func getCachedOrCompute(_ key: String, compute: () -> Bool) -> Bool {
        if let cached = detectionSync({ _detectionCache[key] }) {
            return cached
        }
        let result = compute()
        detectionSync {
            _detectionCache[key] = result
        }
        return result
    }

    /// Detailed jailbreak detection result with individual check results
    /// Note: This performs all checks including expensive ones (process scanning)
    public var jailbreakDetectionDetails: [String: Bool] {
        #if targetEnvironment(simulator)
            return [
                "jailbreakFiles": false,
                "sandboxEscape": false,
                "bashAccess": false,
                "suspiciousProcesses": false,
                "dylibInjection": false
            ]
        #else
        return [
            "jailbreakFiles": getCachedOrCompute("jailbreakFiles", compute: isContainsJailbrokenFiles),
            "sandboxEscape": getCachedOrCompute("sandboxEscape", compute: canWriteOutsideOfSandbox),
            "bashAccess": getCachedOrCompute("bashAccess", compute: checkBashAccess),
            "suspiciousProcesses": getCachedOrCompute("suspiciousProcesses", compute: checkSuspiciousProcesses),
            "dylibInjection": getCachedOrCompute("dylibInjection", compute: checkDylibInjection)
        ]
        #endif
    }

    /// Clear detection cache to force re-evaluation
    public func clearJailbreakCache() {
        detectionSync {
            _detectionCache.removeAll()
            _isJailBroken = nil
        }
    }

    private var _buildTime: String?
    public var buildTime: String {
        if let cached = _buildTime {
            return cached
        }
        let result = "\(getSystemBuildTime())"
        _buildTime = result
        return result
    }

    private var _bootTimeInterval: String?
    public var bootTimeInterval: String {
        if let cached = _bootTimeInterval {
            return cached
        }
        let result = getDeviceBootTime()
        _bootTimeInterval = result
        return result
    }

    private init() {}
}

private extension DeviceInfo {
    // MARK: - Enhanced Jailbreak Detection

    /// Check if bash is accessible
    func checkBashAccess() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
        guard let file = fopen("/bin/bash", "r") else {
            return false
        }
        fclose(file)
        return true
        #endif
    }

    func isContainsJailbrokenFiles() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
        let fileManager = FileManager.default

        // Ordered by likelihood - check most common paths first for early exit
        let jailbreakPaths = [
            // Most common package managers
            "/Applications/Cydia.app",
            "/Applications/Sileo.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/usr/lib/substrate/",

            // Modern jailbreak tools (2020+)
            "/Applications/unc0ver.app",
            "/Applications/checkra1n.app",
            "/Applications/Dopamine.app",
            "/Applications/Palera1n.app",
            "/Applications/TrollStore.app",
            "/Applications/taurine.app",
            "/Applications/odyssey.app",

            // APT/Cydia directories
            "/private/var/lib/apt/",
            "/private/var/lib/cydia/",
            "/var/lib/apt/",
            "/etc/apt/",

            // System binaries
            "/bin/bash",
            "/bin/sh",
            "/usr/sbin/sshd",
            "/usr/bin/ssh",

            // Jailbreak indicators
            "/.installed_unc0ver",
            "/.bootstrapped_electra",
            "/jb/",

            // Older tools (less common)
            "/Applications/Zebra.app",
            "/Applications/Installer.app",
            "/Applications/chimera.app",
            "/Applications/electra.app",
            "/Applications/RockApp.app",
            "/Applications/Icy.app",
            "/Applications/WinterBoard.app",
            "/Applications/SBSettings.app",
            "/Applications/IntelliScreen.app",
            "/Applications/Snoop-itConfig.app",
            "/Applications/blackra1n.app",

            // Additional directories
            "/private/var/stash/",
            "/private/var/cache/apt/",
            "/private/var/log/apt/",
            "/var/lib/cydia/",
            "/etc/apt/sources.list.d/",
            "/etc/apt/undecimus/",
            "/bin/su",
            "/bin/ps",
            "/bin/killall",
            "/usr/bin/scp",
            "/usr/libexec/sftp-server",
            "/usr/libexec/ssh-keysign/",

            // LaunchDaemons
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/Library/LaunchDaemons/com.openssh.sshd.plist",
            "/Library/LaunchDaemons/com.apple.tcpdump.plist",
            "/Library/LaunchDaemons/com.rpetri.rocketbootstrapd.plist",

            // Tweak injection
            "/Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate",
            "/Library/Frameworks/SBSettings.framework/",
            "/usr/lib/TweakInject/",
            "/usr/lib/TweakInject.dylib",
            "/usr/lib/libhooker.dylib",
            "/usr/lib/libsubstitute.dylib",
            "/usr/lib/PreferenceLoader/",
            "/usr/lib/Cephei/",

            // Additional indicators
            "/.cydia_no_stash",
            "/jb/jailbreakd",
            "/jb/lzma",
            "/jb/offsets",
            "/cores/binpack/",
            "/private/jailbreakd",
            "/etc/clutch.conf",
            "/etc/clutch2.conf",
            "/etc/alternatives/",
            "/etc/ssh/"
        ]

        // Check file existence with early exit
        for path in jailbreakPaths {
            if fileManager.fileExists(atPath: path) {
                return true
            }

            // For directories, also check accessibility
            if path.hasSuffix("/") {
                if fileManager.isReadableFile(atPath: path) ||
                   fileManager.isExecutableFile(atPath: path) {
                    return true
                }
            }
        }

        // Check URL schemes (lightweight check)
        return checkJailbreakURLSchemes()
        #endif
    }

    func checkJailbreakURLSchemes() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
        let jailbreakSchemes = [
            "cydia://package/com.example.package",
            "sileo://package/com.example.package",
            "zbra://packages/com.example.package"
        ]

        for scheme in jailbreakSchemes {
            guard let url = URL(string: scheme) else { continue }
            if canOpenURLSafely(url) {
                return true
            }
        }
        return false
        #endif
    }

    func canOpenURLSafely(_ url: URL) -> Bool {
        if Thread.isMainThread {
            return UIApplication.shared.canOpenURL(url)
        }
        return DispatchQueue.main.sync {
            UIApplication.shared.canOpenURL(url)
        }
    }

    func canWriteOutsideOfSandbox() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
        let fileManager = FileManager.default

        // First check: Try to read restricted directories (non-destructive)
        let restrictedDirs = [
            "/var/root",
            "/private/var/root",
            "/var/mobile/Library/AddressBook"
        ]

        for dir in restrictedDirs {
            if fileManager.isReadableFile(atPath: dir) {
                do {
                    let contents = try fileManager.contentsOfDirectory(atPath: dir)
                    if !contents.isEmpty {
                        return true
                    }
                } catch {
                    // Expected to fail on non-jailbroken devices
                }
            }
        }

        // Second check: Try minimal write test (only if read check failed)
        // Use a single, less suspicious path to avoid detection
        let testPath = "/private/.jb_\(UUID().uuidString.prefix(8))"

        do {
            try "t".write(toFile: testPath, atomically: false, encoding: .utf8)
            // Clean up immediately
            try? fileManager.removeItem(atPath: testPath)
            return true
        } catch {
            // Expected to fail on non-jailbroken devices
        }

        return false
        #endif
    }

    // MARK: - Additional Detection Methods

    func checkSuspiciousProcesses() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
        // Optimized process check with early exit
        let suspiciousProcesses = [
            "Cydia", "Sileo", "Zebra", "Installer",
            "unc0ver", "checkra1n", "chimera", "electra",
            "odyssey", "taurine", "TrollStore", "Dopamine", "Palera1n",
            "frida-server", "frida",
            "clutch", "clutch2", "dumpdecrypted"
        ]

        var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_ALL]
        var size: Int = 0

        // Get required buffer size
        guard sysctl(&mib, u_int(mib.count), nil, &size, nil, 0) == 0, size > 0 else {
            return false
        }

        let processCount = size / MemoryLayout<kinfo_proc>.stride

        // Limit process count to prevent excessive memory allocation
        guard processCount < 10000 else {
            return false
        }

        var processes = [kinfo_proc](repeating: kinfo_proc(), count: processCount)

        // Get process list
        let sysctlSucceeded: Bool = processes.withUnsafeMutableBytes { rawBuffer in
            guard let baseAddress = rawBuffer.baseAddress else {
                return false
            }
            return sysctl(&mib, u_int(mib.count), baseAddress, &size, nil, 0) == 0
        }

        guard sysctlSucceeded else {
            return false
        }

        let actualProcessCount = min(processCount, size / MemoryLayout<kinfo_proc>.stride)
        guard actualProcessCount > 0 else {
            return false
        }

        // Check each process with early exit
        for process in processes.prefix(actualProcessCount) {
            let processName = withUnsafeBytes(of: process.kp_proc.p_comm) { rawBytes -> String in
                let bytes = rawBytes.bindMemory(to: UInt8.self)
                let endIndex = bytes.firstIndex(of: 0) ?? bytes.endIndex
                return String(decoding: bytes[..<endIndex], as: UTF8.self)
            }

            // Early exit on first match
            let lowerName = processName.lowercased()
            for suspicious in suspiciousProcesses {
                if lowerName.contains(suspicious.lowercased()) {
                    return true
                }
            }
        }

        return false
        #endif
    }

    func checkDylibInjection() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
        let fileManager = FileManager.default

        // Check for injected dynamic libraries (ordered by likelihood)
        let injectionIndicators = [
            // Most common injection paths
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/usr/lib/substrate/",
            "/usr/lib/TweakInject/",

            // Modern injection frameworks
            "/usr/lib/libhooker.dylib",
            "/usr/lib/libsubstitute.dylib",
            "/Library/MobileSubstrate",

            // Supporting libraries
            "/usr/lib/PreferenceLoader/",
            "/usr/lib/Cephei/",
            "/usr/lib/libsparkapplist",
            "/usr/lib/PreferenceBundles",
            "/usr/lib/TweakInject.dylib",

            // Anti-detection tweaks (ironically help us detect)
            "/Library/MobileSubstrate/DynamicLibraries/Liberty.dylib",
            "/Library/MobileSubstrate/DynamicLibraries/AntiJBDetect.dylib",
            "/Library/MobileSubstrate/DynamicLibraries/Choicy.dylib",
            "/usr/lib/TweakInject/AntiJBDetect.dylib",

            // Framework paths
            "/Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate",
            "/Library/Frameworks/SBSettings.framework/"
        ]

        // Check file existence with early exit
        for path in injectionIndicators {
            if fileManager.fileExists(atPath: path) {
                return true
            }
        }

        // Check if MobileSubstrate is already loaded in memory
        if dlopen("/Library/MobileSubstrate/MobileSubstrate.dylib", RTLD_NOLOAD) != nil {
            return true
        }

        return false
        #endif
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

        "iPhone17,1": "iPhone 16 Pro",
        "iPhone17,2": "iPhone 16 Pro Max",
        "iPhone17,3": "iPhone 16",
        "iPhone17,4": "iPhone 16 Plus",
        "iPhone17,5": "iPhone 16e",
        
        "iPhone18,1" : "iPhone 17 Pro",
        "iPhone18,2" : "iPhone 17 Pro Max",
        "iPhone18,3" : "iPhone 17",
        "iPhone18,4" : "iPhone Air",

        // iPad
        "iPad1,1": "iPad",
        "iPad2,1": "iPad 2 (WiFi)",
        "iPad2,2": "iPad 2 (GSM)",
        "iPad2,3": "iPad 2 (CDMA)",
        "iPad2,4": "iPad 2 (WiFi Rev A)",
        "iPad2,5": "iPad mini (WiFi)",
        "iPad2,6": "iPad mini (GSM)",
        "iPad2,7": "iPad mini (CDMA)",
        "iPad3,1": "iPad (3rd generation) (WiFi)",
        "iPad3,2": "iPad (3rd generation) (CDMA)",
        "iPad3,3": "iPad (3rd generation) (GSM)",
        "iPad3,4": "iPad (4th generation) (WiFi)",
        "iPad3,5": "iPad (4th generation) (GSM)",
        "iPad3,6": "iPad (4th generation) (CDMA)",
        "iPad4,1": "iPad Air (WiFi)",
        "iPad4,2": "iPad Air (Cellular)",
        "iPad4,3": "iPad Air (China)",
        "iPad4,4": "iPad mini 2 (WiFi)",
        "iPad4,5": "iPad mini 2 (Cellular)",
        "iPad4,6": "iPad mini 2 (China)",
        "iPad4,7": "iPad mini 3 (WiFi)",
        "iPad4,8": "iPad mini 3 (Cellular)",
        "iPad4,9": "iPad mini 3 (China)",
        "iPad5,1": "iPad mini 4 (WiFi)",
        "iPad5,2": "iPad mini 4 (Cellular)",
        "iPad5,3": "iPad Air 2 (WiFi)",
        "iPad5,4": "iPad Air 2 (Cellular)",
        "iPad6,3": "iPad Pro (9.7-inch) (WiFi)",
        "iPad6,4": "iPad Pro (9.7-inch) (Cellular)",
        "iPad6,7": "iPad Pro (12.9-inch) (WiFi)",
        "iPad6,8": "iPad Pro (12.9-inch) (Cellular)",
        "iPad6,11": "iPad (5th generation) (WiFi)",
        "iPad6,12": "iPad (5th generation) (Cellular)",
        "iPad7,1": "iPad Pro (12.9-inch) (2nd generation) (WiFi)",
        "iPad7,2": "iPad Pro (12.9-inch) (2nd generation) (Cellular)",
        "iPad7,3": "iPad Pro (10.5-inch) (WiFi)",
        "iPad7,4": "iPad Pro (10.5-inch) (Cellular)",
        "iPad7,5": "iPad (6th generation) (WiFi)",
        "iPad7,6": "iPad (6th generation) (Cellular)",
        "iPad7,11": "iPad (7th generation) (WiFi)",
        "iPad7,12": "iPad (7th generation) (Cellular)",
        "iPad8,1": "iPad Pro (11-inch) (WiFi)",
        "iPad8,2": "iPad Pro (11-inch) (1TB, WiFi)",
        "iPad8,3": "iPad Pro (11-inch) (Cellular)",
        "iPad8,4": "iPad Pro (11-inch) (1TB, Cellular)",
        "iPad8,5": "iPad Pro (12.9-inch) (3rd generation) (WiFi)",
        "iPad8,6": "iPad Pro (12.9-inch) (3rd generation) (1TB, WiFi)",
        "iPad8,7": "iPad Pro (12.9-inch) (3rd generation) (Cellular)",
        "iPad8,8": "iPad Pro (12.9-inch) (3rd generation) (1TB, Cellular)",
        "iPad8,9": "iPad Pro (11-inch) (2nd generation) (WiFi)",
        "iPad8,10": "iPad Pro (11-inch) (2nd generation) (Cellular)",
        "iPad8,11": "iPad Pro (12.9-inch) (4th generation) (WiFi)",
        "iPad8,12": "iPad Pro (12.9-inch) (4th generation) (Cellular)",
        "iPad11,1": "iPad mini (5th generation) (WiFi)",
        "iPad11,2": "iPad mini (5th generation) (Cellular)",
        "iPad11,3": "iPad Air (3rd generation) (WiFi)",
        "iPad11,4": "iPad Air (3rd generation) (Cellular)",
        "iPad11,6": "iPad (8th generation) (WiFi)",
        "iPad11,7": "iPad (8th generation) (Cellular)",
        "iPad12,1": "iPad (9th generation) (WiFi)",
        "iPad12,2": "iPad (9th generation) (Cellular)",
        "iPad13,1": "iPad Air (4th generation) (WiFi)",
        "iPad13,2": "iPad Air (4th generation) (Cellular)",
        "iPad13,4": "iPad Pro (11-inch) (3rd generation)",
        "iPad13,5": "iPad Pro (11-inch) (3rd generation)",
        "iPad13,6": "iPad Pro (11-inch) (3rd generation)",
        "iPad13,7": "iPad Pro (11-inch) (3rd generation)",
        "iPad13,8": "iPad Pro (12.9-inch) (5th generation)",
        "iPad13,9": "iPad Pro (12.9-inch) (5th generation)",
        "iPad13,10": "iPad Pro (12.9-inch) (5th generation)",
        "iPad13,11": "iPad Pro (12.9-inch) (5th generation)",
        "iPad13,16": "iPad Air (5th generation) (WiFi)",
        "iPad13,17": "iPad Air (5th generation) (Cellular)",
        "iPad13,18": "iPad (10th generation) (WiFi)",
        "iPad13,19": "iPad (10th generation) (Cellular)",
        "iPad14,1": "iPad mini (6th generation) (WiFi)",
        "iPad14,2": "iPad mini (6th generation) (Cellular)",
        "iPad14,3": "iPad Pro (11-inch) (4th generation)",
        "iPad14,4": "iPad Pro (11-inch) (4th generation)",
        "iPad14,5": "iPad Pro (12.9-inch) (6th generation)",
        "iPad14,6": "iPad Pro (12.9-inch) (6th generation)",
        "iPad16,1": "iPad mini (7th Gen) (WiFi)",
        "iPad16,2": "iPad mini (7th Gen) (WiFi+Cellular)",
        "iPad16,3": "iPad Pro (11-inch) (5th generation)",
        "iPad16,4": "iPad Pro (11-inch) (5th generation)",
        "iPad16,5": "iPad Pro (12.9-inch) (7th generation)",
        "iPad16,6": "iPad Pro (12.9-inch) (7th generation)",

        // iPod
        "iPod1,1": "iPod touch",
        "iPod2,1": "iPod touch (2nd generation)",
        "iPod3,1": "iPod touch (3rd generation)",
        "iPod4,1": "iPod touch (4th generation)",
        "iPod5,1": "iPod touch (5th generation)",
        "iPod7,1": "iPod touch (6th generation)",
        "iPod9,1": "iPod touch (7th generation)",

        // Simulator
        "i386": "iPhone Simulator",
        "x86_64": "iPhone Simulator",
        "arm64": "iPhone Simulator"
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

        "iPhone17,1": "Apple A18 Pro",
        "iPhone17,2": "Apple A18 Pro",
        "iPhone17,3": "Apple A18",
        "iPhone17,4": "Apple A18",
        "iPhone17,5": "Apple A18",
        
        "iPhone18,1" : "Apple A19 Pro",
        "iPhone18,2" : "Apple A19 Pro",
        "iPhone18,3" : "Apple A19",
        "iPhone18,4" : "Apple A19 Pro",

        // iPad
        "iPad4,1": "Apple A7",
        "iPad4,2": "Apple A7",
        "iPad4,3": "Apple A7",
        "iPad4,4": "Apple A7",
        "iPad4,5": "Apple A7",
        "iPad4,6": "Apple A7",
        "iPad4,7": "Apple A7",
        "iPad4,8": "Apple A7",
        "iPad4,9": "Apple A7",
        "iPad5,1": "Apple A8",
        "iPad5,2": "Apple A8",
        "iPad5,3": "Apple A8X",
        "iPad5,4": "Apple A8X",
        "iPad6,3": "Apple A9X",
        "iPad6,4": "Apple A9X",
        "iPad6,7": "Apple A9X",
        "iPad6,8": "Apple A9X",
        "iPad6,11": "Apple A9",
        "iPad6,12": "Apple A9",
        "iPad7,1": "Apple A10X Fusion",
        "iPad7,2": "Apple A10X Fusion",
        "iPad7,3": "Apple A10X Fusion",
        "iPad7,4": "Apple A10X Fusion",
        "iPad7,5": "Apple A10 Fusion",
        "iPad7,6": "Apple A10 Fusion",
        "iPad7,11": "Apple A10 Fusion",
        "iPad7,12": "Apple A10 Fusion",
        "iPad8,1": "Apple A12X Bionic",
        "iPad8,2": "Apple A12X Bionic",
        "iPad8,3": "Apple A12X Bionic",
        "iPad8,4": "Apple A12X Bionic",
        "iPad8,5": "Apple A12X Bionic",
        "iPad8,6": "Apple A12X Bionic",
        "iPad8,7": "Apple A12X Bionic",
        "iPad8,8": "Apple A12X Bionic",
        "iPad8,9": "Apple A12Z Bionic",
        "iPad8,10": "Apple A12Z Bionic",
        "iPad8,11": "Apple A12Z Bionic",
        "iPad8,12": "Apple A12Z Bionic",
        "iPad11,1": "Apple A12 Bionic",
        "iPad11,2": "Apple A12 Bionic",
        "iPad11,3": "Apple A12 Bionic",
        "iPad11,4": "Apple A12 Bionic",
        "iPad11,6": "Apple A12 Bionic",
        "iPad11,7": "Apple A12 Bionic",
        "iPad12,1": "Apple A13 Bionic",
        "iPad12,2": "Apple A13 Bionic",
        "iPad13,1": "Apple A14 Bionic",
        "iPad13,2": "Apple A14 Bionic",
        "iPad13,4": "Apple M1",
        "iPad13,5": "Apple M1",
        "iPad13,6": "Apple M1",
        "iPad13,7": "Apple M1",
        "iPad13,8": "Apple M1",
        "iPad13,9": "Apple M1",
        "iPad13,10": "Apple M1",
        "iPad13,11": "Apple M1",
        "iPad13,16": "Apple M1",
        "iPad13,17": "Apple M1",
        "iPad13,18": "Apple A14 Bionic",
        "iPad13,19": "Apple A14 Bionic",
        "iPad14,1": "Apple A15 Bionic",
        "iPad14,2": "Apple A15 Bionic",
        "iPad14,3": "Apple M2",
        "iPad14,4": "Apple M2",
        "iPad14,5": "Apple M2",
        "iPad14,6": "Apple M2",

        "iPad16,1": "Apple A17 Pro",
        "iPad16,2": "Apple A17 Pro",
        "iPad16,3": "Apple M4",
        "iPad16,4": "Apple M4",
        "iPad16,5": "Apple M4",
        "iPad16,6": "Apple M4",

        // iPod
        "iPod2,1": "Samsung S5L8720",
        "iPod3,1": "Samsung S5L8922",
        "iPod4,1": "Apple A4",
        "iPod5,1": "Apple A5",
        "iPod7,1": "Apple A8",
        "iPod9,1": "Apple A10 Fusion",

        // Simulator
        "i386": "x86",
        "x86_64": "x86_64",
        "arm64": "Apple Silicon"
    ]
}
