# SwiftHook

SwiftHook is a simple and key-based callback library written in Swift.

Check out the generated docs at [vknabel.github.io/SwiftHook](https://vknabel.github.io/SwiftHook/).

## Installation

SwiftHook is a pure Swift project and supports [Swift Package Manager](https://github.com/apple/swift-package-manager), [Carthage](https://github.com/Carthage/Carthage) and [CocoaPods](https://github.com/CocoaPods/CocoaPods).

### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "YourPackage",
    dependencies: [
        .Package(url: "https://github.com/vknabel/SwiftHook.git", majorVersion: 2)
    ]
)
```

### Carthage

```ruby
github "vknabel/SwiftHook" ~> 2.0.0
```

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'SwiftHook', '~> 2.0.0'
```

## HookKey

A ``HookKey`` is a wrapper around a raw value that adds some additional type information.
This type information gives callbacks compile-time safety.

```swift
/// example for DelegationHook
enum RepositoryPolicy: RawHookKeyType {
  case nameAllowed
}
/// example for SerialHook
enum RepositoryAction: RawHookKeyType {
  case nameChanged
}

extension HookKey {
  static let nameAllowed: HookKey<RepositoryPolicy, String, Bool> = HookKey(rawValue: .nameAllowed)
  static let nameChanged: HookKey<RepositoryAction, String, ()> = HookKey(rawValue: .nameChanged)
}
```

## DelegationHook

A `DelegationHook` only supports one single callback for each hook key and can be used instead of small delegates. Added closures are stored retained.

```swift
var hook = DelegationHook<RepositoryPolicy>()
hook.add(key: .nameAllowed) { string in
  let len = count(string)
  return len > 1 && len < 15
}
let allowed = hook.performAction(forKey: .nameAllowed, with: "SwiftHook") ?? true
```

## SerialHook

A ``SerialHook``supports multiple closures per `HookKey`, but `add(key:, closure:)` returns an optional reference to be stored in a strong reference.

```swift
var hook = SerialHook<RepositoryAction>()
var updateObject = hook.add(key: .nameChanged) { name in /*update title*/ }
var update2Object = hook.add(key: .nameChanged) { name in /*update title in another place*/ }
hook.perform(key: .nameChanged, "NewName")
updateObject = nil // removes the first name changed closure
```

# License
``SwiftHook`` is released unter [MIT License](./LICENSE).
