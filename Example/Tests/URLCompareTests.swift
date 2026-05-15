//
//  URLCompareTests.swift
//  YSTools-Swift_Tests
//

import XCTest
@testable import YSTools_Swift

final class URLCompareTests: XCTestCase {

    func testSchemeAndHostCaseInsensitive() {
        let a = URL(string: "HTTPS://Example.com/path")!
        let b = URL(string: "https://example.com/path")!
        XCTAssertTrue(a.isSameURL(b))
    }

    func testDefaultPortNormalization() {
        let a = URL(string: "https://a.com")!
        let b = URL(string: "https://a.com:443")!
        XCTAssertTrue(a.isSameURL(b))
    }

    func testQueryOrderIndependent() {
        let a = URL(string: "https://a.com/p?x=1&y=2")!
        let b = URL(string: "https://a.com/p?y=2&x=1")!
        XCTAssertTrue(a.isSameURL(b))
    }

    func testFragmentIgnored() {
        let a = URL(string: "https://a.com/p#section")!
        let b = URL(string: "https://a.com/p")!
        XCTAssertTrue(a.isSameURL(b))
    }

    func testDifferentHostsNotEqual() {
        let a = URL(string: "https://a.com/p")!
        let b = URL(string: "https://b.com/p")!
        XCTAssertFalse(a.isSameURL(b))
    }

    func testEmptyPathTreatedAsRoot() {
        let a = URL(string: "https://a.com")!
        let b = URL(string: "https://a.com/")!
        XCTAssertTrue(a.isSameURL(b))
    }

    func testStringToURL() {
        XCTAssertNotNil("  https://a.com  ".toUrl)
        XCTAssertNil("".toUrl)
        XCTAssertNil("   ".toUrl)
    }
}
