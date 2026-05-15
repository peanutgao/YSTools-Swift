//
//  FormatterCache.swift
//  YSTools-Swift
//
//  Created by Joseph Koh on 2026/5/15.
//

import Foundation

/// Thread-safe, bounded cache for expensive formatter / regex objects.
///
/// - Mutable formatter objects are copied before they are returned, so callers
///   can customise the returned formatter without changing the cached template.
/// - `NSRegularExpression` is immutable and thread-safe by design, so cached
///   regex objects can be returned directly.
/// - Backed by `NSCache`, so eviction happens automatically under memory
///   pressure and a hard `countLimit` caps unbounded growth from dynamic
///   format strings.
public enum FormatterCache {
    /// Maximum number of cached entries per category. Keeps memory bounded
    /// when callers feed dynamic format strings.
    public static var countLimit: Int = 64 {
        didSet {
            dateFormatterCache.countLimit = countLimit
            numberFormatterCache.countLimit = countLimit
            regexCache.countLimit = countLimit
        }
    }

    private static let dateFormatterCache: NSCache<NSString, DateFormatter> = {
        let c = NSCache<NSString, DateFormatter>()
        c.countLimit = countLimit
        return c
    }()

    private static let numberFormatterCache: NSCache<NSString, NumberFormatter> = {
        let c = NSCache<NSString, NumberFormatter>()
        c.countLimit = countLimit
        return c
    }()

    private static let regexCache: NSCache<NSString, NSRegularExpression> = {
        let c = NSCache<NSString, NSRegularExpression>()
        c.countLimit = countLimit
        return c
    }()

    public static func dateFormatter(format: String, locale: Locale = .current, timeZone: TimeZone? = nil) -> DateFormatter {
        let key = "\(format)|\(locale.identifier)|\(timeZone?.identifier ?? "_")" as NSString
        if let f = dateFormatterCache.object(forKey: key) { return copyDateFormatter(f) }
        let f = DateFormatter()
        f.dateFormat = format
        f.locale = locale
        if let timeZone { f.timeZone = timeZone }
        dateFormatterCache.setObject(f, forKey: key)
        return copyDateFormatter(f)
    }

    public static func numberFormatter(style: NumberFormatter.Style, groupingSeparator: String? = nil, locale: Locale = .current) -> NumberFormatter {
        let key = "\(style.rawValue)|\(groupingSeparator ?? "_")|\(locale.identifier)" as NSString
        if let f = numberFormatterCache.object(forKey: key) { return copyNumberFormatter(f) }
        let f = NumberFormatter()
        f.numberStyle = style
        if let groupingSeparator {
            f.groupingSeparator = groupingSeparator
        }
        f.locale = locale
        numberFormatterCache.setObject(f, forKey: key)
        return copyNumberFormatter(f)
    }

    public static func regex(pattern: String, options: NSRegularExpression.Options = []) -> NSRegularExpression? {
        let key = "\(pattern)|\(options.rawValue)" as NSString
        if let r = regexCache.object(forKey: key) { return r }
        guard let r = try? NSRegularExpression(pattern: pattern, options: options) else { return nil }
        regexCache.setObject(r, forKey: key)
        return r
    }

    private static func copyDateFormatter(_ formatter: DateFormatter) -> DateFormatter {
        guard let copied = formatter.copy() as? DateFormatter else {
            return DateFormatter()
        }
        return copied
    }

    private static func copyNumberFormatter(_ formatter: NumberFormatter) -> NumberFormatter {
        guard let copied = formatter.copy() as? NumberFormatter else {
            return NumberFormatter()
        }
        return copied
    }
}
