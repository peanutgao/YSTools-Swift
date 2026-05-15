//
//  DateExtensionsTests.swift
//  YSTools-Swift_Tests
//

import XCTest
@testable import YSTools_Swift

final class DateExtensionsTests: XCTestCase {

    func testFormatRoundTrip() {
        let raw = "2026-05-15 12:34:56"
        guard let date = Date(string: raw) else {
            XCTFail("Date parse failed")
            return
        }
        XCTAssertEqual(date.string(), raw)
    }

    func testComponentAccessors() {
        guard let date = Date(string: "2026-05-15 12:34:56") else {
            XCTFail("Date parse failed")
            return
        }
        XCTAssertEqual(date.year, 2026)
        XCTAssertEqual(date.month, 5)
        XCTAssertEqual(date.day, 15)
        XCTAssertEqual(date.hour, 12)
        XCTAssertEqual(date.minute, 34)
        XCTAssertEqual(date.second, 56)
    }

    func testStartAndEndOfDay() {
        guard let date = Date(string: "2026-05-15 12:34:56") else {
            XCTFail("Date parse failed")
            return
        }
        XCTAssertEqual(date.startOfDay.string(), "2026-05-15 00:00:00")
        XCTAssertEqual(date.endOfDay.string(), "2026-05-15 23:59:59")
    }

    func testFormatterCacheReuse() {
        // NSCache may evict under memory pressure, but within a tight loop the
        // formatter is reused and produces identical output for identical input.
        let date = Date(timeIntervalSince1970: 0)
        let f1 = FormatterCache.dateFormatter(format: "yyyy-MM-dd HH:mm:ss")
        let f2 = FormatterCache.dateFormatter(format: "yyyy-MM-dd HH:mm:ss")
        XCTAssertEqual(f1.string(from: date), f2.string(from: date))
    }

    func testFormatterCacheCountLimit() {
        let oldLimit = FormatterCache.countLimit
        FormatterCache.countLimit = 4
        defer { FormatterCache.countLimit = oldLimit }
        // Exercise more keys than the cap; formatter should still be valid.
        for i in 0..<8 {
            let f = FormatterCache.dateFormatter(format: "yyyy-\(i)-MM-dd")
            XCTAssertNotNil(f)
        }
    }

    func testFormatterCacheReturnsMutableCopies() {
        let f1 = FormatterCache.dateFormatter(format: "yyyy")
        f1.dateFormat = "MM"

        let f2 = FormatterCache.dateFormatter(format: "yyyy")
        XCTAssertEqual(f2.dateFormat, "yyyy")

        let n1 = FormatterCache.numberFormatter(style: .decimal, groupingSeparator: ",")
        n1.groupingSeparator = "_"

        let n2 = FormatterCache.numberFormatter(style: .decimal, groupingSeparator: ",")
        XCTAssertEqual(n2.groupingSeparator, ",")
    }

    func testTimeAgoDisplayHandlesFutureDate() {
        let future = Date(timeIntervalSinceNow: 2 * 60 * 60 + 60)
        XCTAssertEqual(future.timeAgoDisplay, "In 2 hours")
    }
}
