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
    
    /// Throttles execution of a block.
    /// - Parameters:
    ///   - delay: The time interval to wait before execution.
    ///   - queue: The queue to execute on.
    ///   - action: The block to execute.
    /// - Returns: A closure that can be called to trigger the throttled action.
    public static func throttle(delay: TimeInterval, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
        var workItem: DispatchWorkItem?
        var lastRun: Date = Date.distantPast
        
        return {
            workItem?.cancel()
            workItem = DispatchWorkItem(block: {
                let now = Date()
                if now.timeIntervalSince(lastRun) > delay {
                    action()
                    lastRun = now
                }
            })
            if let workItem = workItem {
                queue.asyncAfter(deadline: .now() + delay, execute: workItem)
            }
        }
    }
    
    /// Debounces execution of a block.
    /// - Parameters:
    ///   - delay: The time interval to wait before execution.
    ///   - queue: The queue to execute on.
    ///   - action: The block to execute.
    /// - Returns: A closure that can be called to trigger the debounced action.
    public static func debounce(delay: TimeInterval, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
        var workItem: DispatchWorkItem?
        
        return {
            workItem?.cancel()
            workItem = DispatchWorkItem(block: action)
            if let workItem = workItem {
                queue.asyncAfter(deadline: .now() + delay, execute: workItem)
            }
        }
    }
}
