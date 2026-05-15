//
//  GCDTests.swift
//  YSTools-Swift_Tests
//

import XCTest
@testable import YSTools_Swift

final class GCDTests: XCTestCase {

    func testThrottleFiresFirstThenSuppresses() {
        let exp = expectation(description: "throttle ran")
        var count = 0
        let throttled = GCD.throttle(interval: 0.2, queue: .main) {
            count += 1
            if count == 1 { exp.fulfill() }
        }
        for _ in 0..<5 { throttled() }
        wait(for: [exp], timeout: 1.0)
        // give a brief async window for any stray dispatch
        let waitExp = expectation(description: "settle")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { waitExp.fulfill() }
        wait(for: [waitExp], timeout: 1.0)
        XCTAssertEqual(count, 1)
    }

    func testDebounceFiresOnceAfterQuiet() {
        let exp = expectation(description: "debounce fired")
        var count = 0
        let debounced = GCD.debounce(delay: 0.1, queue: .main) {
            count += 1
            exp.fulfill()
        }
        debounced()
        debounced()
        debounced()
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(count, 1)
    }

    func testRunOnMainExecutesImmediately() {
        var ran = false
        GCD.runOnMain { ran = true }
        XCTAssertTrue(ran)
    }

    func testDelayExecutes() {
        let exp = expectation(description: "delay ran")
        GCD.delay(0.05) { exp.fulfill() }
        wait(for: [exp], timeout: 1.0)
    }
}
