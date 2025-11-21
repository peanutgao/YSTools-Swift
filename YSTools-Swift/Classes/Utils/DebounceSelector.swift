//
//  DebounceSelector.swift
//  
//
//  Created by Joseph on 2025/11/21.
//

import Foundation

public class DebounceSelector {
    private var isExecuting = false
    private let debounceInterval: TimeInterval
    
    public init(debounceInterval: TimeInterval = 0.6) {
        self.debounceInterval = debounceInterval
    }
    
    public func execute(_ action: @escaping () -> Void) {
        guard !isExecuting else { return }
        
        isExecuting = true
        action()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval) { [weak self] in
            self?.isExecuting = false
        }
    }
}

public extension DebounceSelector {
    static let `default` = DebounceSelector(debounceInterval: 0.6)
}
