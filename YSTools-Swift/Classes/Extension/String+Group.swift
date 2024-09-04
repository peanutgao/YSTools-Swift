//
//  String+Group.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2024/9/4.
//

import Foundation

public extension String {

    func grouped(by groupSizes: [Int], separator: String = " ") -> String {
        var result = ""
        var currentIndex = self.startIndex
        
        for (index, size) in groupSizes.enumerated() {
            guard currentIndex < self.endIndex else { break }
            
            let endIndex = self.index(currentIndex, offsetBy: size, limitedBy: self.endIndex) ?? self.endIndex
            let substring = self[currentIndex..<endIndex]
            
            if !result.isEmpty {
                result += separator
            }
            result += String(substring)
            
            currentIndex = endIndex
        }
        
        // handle the remaining
        if currentIndex < self.endIndex {
            if !result.isEmpty {
                result += separator
            }
            result += String(self[currentIndex...])
        }
        
        return result
    }
    
    
    func grouped(every size: Int, with separator: String = " ") -> String {
        guard size > 0 else { return self }
        
        var result = ""
        var currentIndex = self.startIndex
        
        while currentIndex < self.endIndex {
            if !result.isEmpty {
                result += separator
            }
            
            let endIndex = self.index(currentIndex, offsetBy: size, limitedBy: self.endIndex) ?? self.endIndex
            result += String(self[currentIndex..<endIndex])
            currentIndex = endIndex
        }
        
        return result
    }
    
    func groupedByPattern(_ pattern: [(size: Int, repeat: Int)], separator: String = " ") -> String {
        var result = ""
        var currentIndex = self.startIndex
        
        for (size, repeatCount) in pattern {
            for _ in 0..<repeatCount {
                guard currentIndex < self.endIndex else { break }
                
                let endIndex = self.index(currentIndex, offsetBy: size, limitedBy: self.endIndex) ?? self.endIndex
                let substring = self[currentIndex..<endIndex]
                
                if !result.isEmpty {
                    result += separator
                }
                result += String(substring)
                
                currentIndex = endIndex
                
                if currentIndex >= self.endIndex {
                    break
                }
            }
        }
        
        if currentIndex < self.endIndex {
            if !result.isEmpty {
                result += separator
            }
            result += String(self[currentIndex...])
        }
        
        return result
    }
}
