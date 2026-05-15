//
//  StringExtensionsTests.swift
//  YSTools-Swift_Tests
//

import XCTest
import UIKit
@testable import YSTools_Swift

final class StringExtensionsTests: XCTestCase {

    func testIsValidEmail() {
        XCTAssertTrue("foo@bar.com".isValidEmail)
        XCTAssertTrue("a.b+c@example.co.uk".isValidEmail)
        XCTAssertFalse("not-an-email".isValidEmail)
        XCTAssertFalse("missing@tld".isValidEmail)
        XCTAssertFalse("prefix foo@bar.com suffix".isValidEmail)
    }

    func testIsValidURLRequiresFullString() {
        XCTAssertTrue("https://example.com/path?a=1&b=2".isValidURL)
        XCTAssertFalse("prefix https://example.com".isValidURL)
    }

    func testIsValidPhone() {
        XCTAssertTrue("13800138000".isValidPhone)
        XCTAssertFalse("12345".isValidPhone)
        XCTAssertFalse("1380013800a".isValidPhone)
    }

    func testIsNumber() {
        XCTAssertTrue("123456".isNumber)
        XCTAssertFalse("123a".isNumber)
    }

    func testMD5() {
        XCTAssertEqual("hello".md5(), "5d41402abc4b2a76b9719d911017c592")
        XCTAssertEqual("".md5(), "d41d8cd98f00b204e9800998ecf8427e")
    }

    func testEncrypted() {
        XCTAssertEqual("13812345678".encrypted(keepingPrefix: 3, andSuffix: 4), "138****5678")
        XCTAssertEqual("abc".encrypted(keepingPrefix: 5, andSuffix: 5), "***")
        XCTAssertEqual("abc".encrypted(keepingPrefix: 1, andSuffix: 2), "***")
        XCTAssertEqual("abc".encrypted(keepingPrefix: -1, andSuffix: 1), "***")
    }

    func testExtractMatches() {
        let matches = "abc 123 def 456".extractMatches(pattern: #"\d+"#)
        XCTAssertEqual(matches, ["123", "456"])
    }

    func testToAttributedStringEscapesHTML() {
        let attributedString = "<b>x</b> & y".toAttributedString(fontSize: 14)
        XCTAssertEqual(attributedString?.string, "<b>x</b> & y")
    }

    func testGroupedIgnoresInvalidSizes() {
        XCTAssertEqual("12345".grouped(by: [0, 2], separator: "-"), "12-345")
        XCTAssertEqual("12345".grouped(by: [0, -1], separator: "-"), "12345")
        XCTAssertEqual("123456".groupedByPattern([(0, 2), (2, 2)], separator: "-"), "12-34-56")
        XCTAssertEqual("123456".groupedByPattern([(2, 0), (-1, 3)], separator: "-"), "123456")
    }

    func testStringIntegerSubscriptsDoNotCrashOnInvalidRanges() {
        let value = "abc"

        XCTAssertEqual(value[-1], "")
        XCTAssertEqual(value[3], "")
        XCTAssertEqual(value[0..<2], "ab")
        XCTAssertEqual(value[-1..<2], "")
        XCTAssertEqual(value[0..<8], "")
        XCTAssertEqual(value[0...2], "abc")
        XCTAssertEqual(value[0...3], "")
        XCTAssertEqual(value.substring(from: -1), "abc")
    }

    func testNumberConversionsDoNotCrashOnInvalidValues() {
        XCTAssertNil("nan".toInt())
        XCTAssertNil("inf".toInt64())
        XCTAssertEqual("12.9".toInt(), 12)
        XCTAssertEqual(Double.nan.toInt(), 0)
        XCTAssertEqual(Double.infinity.toInt64(), 0)
        XCTAssertEqual(Double.greatestFiniteMagnitude.toInt(), Int.max)
        XCTAssertEqual((-Double.greatestFiniteMagnitude).toInt64(), Int64.min)
    }

    func testAttributedStringHelpersIgnoreInvalidRanges() {
        let attributedString = NSMutableAttributedString(string: "abc")
        attributedString
            .ys_addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 10, length: 1))
            .ys_addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 1, length: 99))

        XCTAssertEqual(attributedString.length, 3)
    }

    func testAttributedStringBuilderIgnoresEmptyGlobalAttributes() {
        let result = AttributedStringBuilder()
            .lineSpacing(4, scopeAll: true)
            .addAttributesAll([.foregroundColor: UIColor.red])
            .build()

        XCTAssertEqual(result.length, 0)
    }

    func testQRCodeReturnsCGBackedImage() {
        let image = QRCodeUtil.createQRForString(qrString: "https://example.com", logoImageName: nil)
        XCTAssertNotNil(image?.cgImage)
    }

    func testUIImageViewCreateMethodsWorkWithoutWebImage() {
        let image = UIImage()
        let imageView = UIImageView(imageName: nil)
            .ys_setImage(with: image)
            .ys_tintColor(.red)
            .ys_isHighlighted(false)

        XCTAssertTrue(imageView.image === image)
        XCTAssertEqual(imageView.tintColor, .red)
        XCTAssertFalse(imageView.isHighlighted)
    }
}
