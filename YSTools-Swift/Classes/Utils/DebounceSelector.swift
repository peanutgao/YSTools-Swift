//
//  DebounceSelector.swift
//  
//
//  Created by Joseph on 2025/11/21.
//

import Foundation

public class DebounceSelector {
    private var isExecuting = false
    private let lock = NSLock()
    private let debounceInterval: TimeInterval

    public init(debounceInterval: TimeInterval = 0.6) {
        self.debounceInterval = debounceInterval
    }

    public func execute(_ action: @escaping () -> Void) {
        lock.lock()
        if isExecuting {
            lock.unlock()
            return
        }
        isExecuting = true
        lock.unlock()

        action()

        DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval) { [weak self] in
            guard let self else { return }
            self.lock.lock()
            self.isExecuting = false
            self.lock.unlock()
        }
    }
}

public extension DebounceSelector {
    static let `default` = DebounceSelector(debounceInterval: 0.6)
}
