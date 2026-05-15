# YSTools-Swift

[![CI](https://github.com/peanutgao/YSTools-Swift/actions/workflows/ci.yml/badge.svg)](https://github.com/peanutgao/YSTools-Swift/actions/workflows/ci.yml)
[![Version](https://img.shields.io/cocoapods/v/YSTools-Swift.svg?style=flat)](https://cocoapods.org/pods/YSTools-Swift)
[![License](https://img.shields.io/cocoapods/l/YSTools-Swift.svg?style=flat)](https://cocoapods.org/pods/YSTools-Swift)
[![Platform](https://img.shields.io/cocoapods/p/YSTools-Swift.svg?style=flat)](https://cocoapods.org/pods/YSTools-Swift)

A modular Swift utility library for iOS 13+. Foundation/UIKit extensions, fluent SDK builders, and runtime utilities — all opt-in via subspec so you only ship what you use.

## Requirements

- iOS 13.0+
- Swift 5.9+
- Xcode 15+

## Installation

```ruby
# Default: Extension + Create + Utils (no SDWebImage)
pod 'YSTools-Swift'

# Add SDWebImage-backed image helpers (UIButton/UIImageView)
pod 'YSTools-Swift', :subspecs => ['Extension', 'Create', 'Utils', 'WebImage']
```

## Subspecs

| Subspec     | Contents                                                            | External deps      |
|-------------|---------------------------------------------------------------------|--------------------|
| `Extension` | `Foundation`/`UIKit` extensions on `String`, `Date`, `UIView`, etc. | none               |
| `Create`    | Fluent chainable builders (`ys_xxx`) for ~30 UIKit types            | none               |
| `Utils`     | `GCD`, `DeviceInfo`, `PermissionHelper`, `QRCodeUtil`, etc.         | none               |
| `WebImage`  | `UIButton+SetImage`, `UIImageView+WebImage` SDWebImage helpers      | `SDWebImage >= 5`  |

## Usage

### Fluent builders

```swift
let label = UILabel()
    .ys_text("Hello")
    .ys_font(.systemFont(ofSize: 16))
    .ys_textColor(.label)
    .ys_textAlignment(.center)
    .ys_numberOfLines(0)
    .ys_inView(view)

let button = UIButton(type: .system)
    .ys_setTitle("Tap", state: .normal)
    .ys_setTitleColor(.white, state: .normal)
    .ys_setBackgroundColor(.systemBlue, for: .normal)
    .ys_setCorner(radius: 8, clickToBounds: true)
    .ys_action(event: .touchUpInside) { btn in
        print("tapped: \(btn)")
    }
```

### Cached formatters & regex

```swift
let now = Date().string(format: "yyyy-MM-dd")        // DateFormatter cached
let pretty = 1234567.formatAsThousandSeparated()      // NumberFormatter cached
let isMail = "foo@bar.com".isValidEmail               // NSRegularExpression cached
```

### Async image compression

```swift
let data = await image.compressAsync(to: 200 * 1024)
```

### URL canonical comparison

```swift
URL(string: "HTTPS://A.com:443/p?b=2&a=1")!
    .isSameURL(URL(string: "https://a.com/p?a=1&b=2"))   // true
```

### GCD helpers

```swift
let throttled = GCD.throttle(interval: 0.5) { print("fires at most every 0.5s") }
let debounced = GCD.debounce(delay: 0.3) { print("fires after 0.3s of silence") }
```

### Property wrappers for UserDefaults

```swift
struct Settings {
    @UserDefault(key: "username", defaultValue: "") var username: String
    @CodableUserDefault(key: "profile", defaultValue: Profile.empty) var profile: Profile
}
```

## Migration: 0.6.x → 1.0.0

- **iOS deployment target raised to 13.0**, Swift 5.9.
- **Breaking**: `UIButton.ys_action(event:acton:)` parameter renamed to `action:`.
- **Breaking**: `GCD.throttle(delay:queue:action:)` → `throttle(interval:queue:action:)`. Behavior fix: now true throttle (rate-limit), not debounce.
- **Breaking**: `@UserDefault` for `Codable` types split into `@CodableUserDefault` to avoid wrappedValue ambiguity.
- **Breaking**: `SDWebImage` no longer a default dependency. Add the `WebImage` subspec to keep URL-backed `UIImageView` / `UIButton` image helpers.
- Image URL helpers no longer allow invalid SSL certificates by default. Pass SDWebImage options explicitly if a legacy environment requires it.

See [CHANGELOG.md](CHANGELOG.md) for the full list.

## Author

peanutgao — peanutgao@hotmail.com

## License

YSTools-Swift is released under the MIT license. See [LICENSE](LICENSE).
