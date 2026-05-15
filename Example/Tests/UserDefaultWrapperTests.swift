//
//  UserDefaultWrapperTests.swift
//  YSTools-Swift_Tests
//

import XCTest
@testable import YSTools_Swift

final class UserDefaultWrapperTests: XCTestCase {

    func testOptionalUserDefaultReadsStoredValue() {
        let suiteName = "com.ystools.tests.\(UUID().uuidString)"
        guard let defaults = UserDefaults(suiteName: suiteName) else {
            XCTFail("UserDefaults suite creation failed")
            return
        }
        defer {
            defaults.removePersistentDomain(forName: suiteName)
        }

        var flag = UserDefault<Bool?>(key: "flag", defaultValue: nil, container: defaults)
        flag.wrappedValue = true

        XCTAssertEqual(flag.wrappedValue, true)

        flag.wrappedValue = nil
        XCTAssertNil(defaults.object(forKey: "flag"))
        XCTAssertNil(flag.wrappedValue)
    }
}
