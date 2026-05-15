//
//  GCD.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation

public struct GCD {
    
    /// Executes a block on the main thread.
    /// - Parameter block: The block to execute.
    public static func runOnMain(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async(execute: block)
        }
    }
    
    /// Executes a block on a background thread (global queue).
    /// - Parameters:
    ///   - qos: The quality of service class (default is .default).
    ///   - block: The block to execute.
    public static func runOnBackground(qos: DispatchQoS.QoSClass = .default, _ block: @escaping () -> Void) {
        DispatchQueue.global(qos: qos).async(execute: block)
    }
    
    /// Executes a block after a specified delay.
    /// - Parameters:
    ///   - seconds: The delay in seconds.
    ///   - queue: The queue to run the block on (default is .main).
    ///   - block: The block to execute.
    public static func delay(_ seconds: Double, queue: DispatchQueue = .main, _ block: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + seconds, execute: block)
    }
    
    /// True throttle: fires immediately, then ignores subsequent calls within `interval`.
    /// - Parameters:
    ///   - interval: Minimum interval between invocations.
    ///   - queue: Queue to execute on.
    ///   - action: Block to execute.
    /// - Returns: Closure to call when triggering the throttled action.
    /// - Important: **The returned closure holds the throttle's state**. You must
    ///   store it (e.g. as a property) and reuse the same instance for each
    ///   call site. Calling `throttle(...)` inside a hot path (e.g. a scroll
    ///   callback) creates a new closure each time and disables rate limiting.
    public static func throttle(interval: TimeInterval, queue: DispatchQueue = .main, action: @escaping () -> Void) -> () -> Void {
        let lock = NSLock()
        var lastRun: Date = .distantPast

        return {
            lock.lock()
            let now = Date()
            let shouldRun = now.timeIntervalSince(lastRun) >= interval
            if shouldRun {
                lastRun = now
                queue.async(execute: action)
            }
            lock.unlock()
        }
    }

    /// Debounces execution: fires only after `delay` of silence since last call.
    /// - Parameters:
    ///   - delay: Quiet period required before firing.
    ///   - queue: Queue to execute on.
    ///   - action: Block to execute.
    /// - Returns: Closure to call when triggering the debounced action.
    /// - Important: **The returned closure holds the debounce's state**. You must
    ///   store it (e.g. as a property) and reuse the same instance for each
    ///   call site. Calling `debounce(...)` per invocation produces a fresh
    ///   work item each time and silently breaks the contract.
    public static func debounce(delay: TimeInterval, queue: DispatchQueue = .main, action: @escaping () -> Void) -> () -> Void {
        let lock = NSLock()
        var workItem: DispatchWorkItem?

        return {
            lock.lock()
            workItem?.cancel()
            let item = DispatchWorkItem(block: action)
            workItem = item
            lock.unlock()
            queue.asyncAfter(deadline: .now() + delay, execute: item)
        }
    }
}
