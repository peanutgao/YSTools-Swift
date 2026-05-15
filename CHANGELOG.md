# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-15

### Added

- `FormatterCache` (thread-safe `DateFormatter` / `NumberFormatter` / `NSRegularExpression` cache).
- 18 new fluent `Create` modules: `UISegmentedControl`, `UISlider`, `UIPageControl`, `UIProgressView`, `UIActivityIndicatorView`, `UIStepper`, `UISearchBar`, `UIDatePicker`, `UIPickerView`, `UIRefreshControl`, `UIVisualEffectView`, `UIBarButtonItem`, `UIBars` (NavigationBar/TabBar/Toolbar), `UIAlertController`, `UIBezierPath`, `CALayer` (+ `CAGradientLayer` / `CAShapeLayer`), `NSMutableAttributedString`, `UIGestureRecognizer` family.
- Async wrapper `UIImage.compressAsync(to:)`.
- `@CodableUserDefault` property wrapper.
- `PermissionHelper.requestLocation(_:type:)` instance-based location flow.
- GitHub Actions CI (`pod lib lint` + SwiftLint + tests).
- SwiftLint config with `force_unwrapping` / `force_cast` opt-in.
- 25 unit tests (String / Date / URL+Compare / GCD).
- README + CHANGELOG.

### Changed

- **iOS deployment target raised to 13.0** (was 11.0).
- **Swift toolchain raised to 5.9** (was 5.0).
- `GCD.throttle` rewritten as true throttle with `(interval:queue:action:)` signature; previous implementation was actually a debounce.
- `GCD.debounce` made thread-safe with `NSLock`.
- `UIViewController+Alert` annotated `@MainActor`.
- `Date.string(format:)` and `Date(string:format:)` now share a cached `DateFormatter`.
- `Int.formatAsThousandSeparated` / `String.formatAsThousandSeparated` use cached `NumberFormatter`.
- `String.matches(pattern:)` / `extractMatches(pattern:)` use cached `NSRegularExpression`.
- `FormatterCache` returns mutable formatter copies so caller changes cannot pollute cached templates.
- `QRCodeUtil` migrated from deprecated `UIGraphicsBeginImageContext` to `UIGraphicsImageRenderer` and now returns CG-backed images.
- `UIImage.compress` migrated from `UIGraphicsBeginImageContext` to `UIGraphicsImageRenderer`.
- `SDWebImage` is no longer a default dependency. The `WebImage` subspec is opt-in.
- SDWebImage helpers retry failed requests by default, but no longer allow invalid SSL certificates unless callers pass that option explicitly.

### Fixed

- **Crash**: `UIImage.compress` force-unwrapped `jpegData(compressionQuality:)` and `UIImage(data:)` — both now safely fall back.
- **Crash**: `FileManager.documentsDirectory` / `cachesDirectory` force-unwrapped `urls(...).first`.
- **Crash**: `Date.endOfDay` force-unwrapped `Calendar.date(byAdding:to:)`.
- **Crash**: `UIColor.hexString` did not validate `cgColor.components` length (CMYK / monochrome inputs).
- **Crash**: `String.boundingRect` force-unwrapped `lineSpacing`.
- **Crash**: `String.md5` force-unwrapped `cString(using:)`.
- **Crash**: `QRCodeUtil` force-unwrapped `CIFilter(name:)` and `colorFilter.outputImage`.
- **Warning**: `String.md5()` now uses CryptoKit instead of deprecated `CC_MD5`.
- **Warning**: `UIButton.ys_action` associated object key now uses a stable byte key.
- **Bug**: `UIButton.ys_action` `__ys_allEventsAction` read the wrong key (`allEditingEvents`), causing `.allEvents` callbacks to misfire.
- **Memory**: `String.md5` no longer allocates a manual digest buffer.

### Breaking changes

- `UIButton.ys_action(event:acton:)` → `ys_action(event:action:)` (typo fix).
- `GCD.throttle(delay:queue:action:)` → `throttle(interval:queue:action:)`.
- `@UserDefault` no longer overloads `wrappedValue` for `Codable`. Use `@CodableUserDefault` for custom Codable types.
- Default subspec set excludes `WebImage`. To restore prior behavior:
  ```ruby
  pod 'YSTools-Swift', :subspecs => ['Extension', 'Create', 'Utils', 'WebImage']
  ```
- `PermissionHelper.request(for: .locationWhenInUse, completion:)` now always reports `false`. Use `requestLocation(_:type:)` with a caller-owned `CLLocationManager`.

## [0.6.0] - 2026-03-26

- Add URL Compare Utils (`URL.isSameURL` with canonical-form comparison).

## [0.5.x and earlier]

See git history for detail.
