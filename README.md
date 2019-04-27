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
        .package(url: "https://github.com/vknabel/SwiftHook.git", from: "3.0.0")
    ]
)
```

### Carthage

```ruby
github "vknabel/SwiftHook" ~> 3.0.0
```

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'SwiftHook', '~> 3.0.0'
```

## HookEvent

A ``HookEvent`` is a wrapper around a raw value that adds some additional type information.
This type information gives callbacks compile-time safety.

```swift
/// example for DelegationHook
enum RepositoryPolicy: HookAction {
  case nameAllowed
}
/// example for SerialHook
enum RepositoryAction: HookAction {
  case nameChanged
}

extension HookEvent {
  static let nameAllowed: HookEvent<RepositoryPolicy, String, Bool> = HookEvent(action: .nameAllowed)
  static let nameChanged: HookEvent<RepositoryAction, String, ()> = HookEvent(action: .nameChanged)
}
```

## DelegationHook

A `DelegationHook` only supports one single callback for each hook key and can be used instead of small delegates. Added closures are stored retained.

```swift
var hook = DelegationHook<RepositoryPolicy>()
hook.respond(to: .nameAllowed) { string in
  let len = count(string)
  return len > 1 && len < 15
}
let allowed = hook.trigger(event: .nameAllowed, with: "SwiftHook")
  .reduce(into: true, { $0 && $1 })
```

## SerialHook

A ``SerialHook``supports multiple closures per `HookEvent`, but `respond(to:, with:)` returns an optional reference to be stored in a strong reference.

```swift
var hook = SerialHook<RepositoryAction>()
var updateObject = hook.respond(to: .nameChanged) { name in /*update title*/ }
var update2Object = hook.respond(to: .nameChanged) { name in /*update title in another place*/ }
hook.trigger(event: .nameChanged, with: "NewName")
updateObject = nil // removes the first name changed closure
```

# License
``SwiftHook`` is released unter [MIT License](./LICENSE).
