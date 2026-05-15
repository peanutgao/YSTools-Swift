//
//  Date+Ext.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2025/12/16.
//

import Foundation

public extension Date {
    
    /// Returns a string representation of the date using the specified format.
    /// - Parameter format: The date format string (default is "yyyy-MM-dd HH:mm:ss").
    /// - Returns: The formatted date string.
    func string(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return FormatterCache.dateFormatter(format: format).string(from: self)
    }

    /// Initializes a Date from a string using the specified format.
    /// - Parameters:
    ///   - string: The date string.
    ///   - format: The format of the date string (default is "yyyy-MM-dd HH:mm:ss").
    init?(string: String, format: String = "yyyy-MM-dd HH:mm:ss") {
        guard let date = FormatterCache.dateFormatter(format: format).date(from: string) else {
            return nil
        }
        self = date
    }
    
    /// Returns the year component of the date.
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    /// Returns the month component of the date.
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    /// Returns the day component of the date.
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// Returns the hour component of the date.
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// Returns the minute component of the date.
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// Returns the second component of the date.
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /// Returns a relative time string (e.g., "Just now", "5 mins ago", "Yesterday").
    var timeAgoDisplay: String {
        let secondsAgo = Int(Date().timeIntervalSince(self))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day

        if secondsAgo < 0 {
            let secondsFromNow = abs(secondsAgo)
            if secondsFromNow < minute {
                return "Just now"
            } else if secondsFromNow < hour {
                return "In \(secondsFromNow / minute) mins"
            } else if secondsFromNow < day {
                return "In \(secondsFromNow / hour) hours"
            } else if secondsFromNow < week {
                return "In \(secondsFromNow / day) days"
            }
            return string(format: "yyyy-MM-dd")
        } else if secondsAgo < minute {
            return "Just now"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) mins ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        
        return string(format: "yyyy-MM-dd")
    }
    
    /// Checks if the date is in today.
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// Checks if the date is in yesterday.
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    /// Checks if the date is in tomorrow.
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    /// Returns the start of the day (00:00:00).
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// Returns the end of the day (23:59:59). Falls back to `startOfDay` if the
    /// calendar arithmetic fails (e.g. invalid components for a non-Gregorian
    /// calendar) so the returned value still belongs to the same day.
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? startOfDay
    }
}
