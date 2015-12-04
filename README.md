# ConclurerHook [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/conclurer/ConclurerHook/master/LICENSE) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![Swift Package Manager compatible](https://img.shields.io/badge/Swift Package Manager-compatible-brightgreen.svg?style=flat)

This framework provides an API for easily handling many callbacks in Swift.

## HookKey

A ``HookKey`` is a wrapper around a raw value that adds some additional type information.
This type information gives callbacks compile-time safety.

```swift
/// example for DelegationHook
enum RepositoryPolicy: RawHookKeyType {
  case NameAllowed
}
/// example for SerialHook
enum RepositoryAction: RawHookKeyType {
  case NameChanged
}

extension HookKey {
  static let nameAllowedKey: HookKey<RepositoryPolicy, String, Bool> = HookKey(rawValue: .NameAllowed)
  static let nameChangedKey: HookKey<RepositoryAction, String, ()> = HookKey(rawValue: .NameChanged)
}
```

## DelegationHook

A ``DelegationHook`` only supports one single callback for each hook key and can be used instead of small delegates. Added closures are stored retained. 

```swift
var hook = DelegationHook<RepositoryPolicy>()
hook.add(key: .nameAllowedKey) { string in 
  let len = count(string)
  return len > 1 && len < 15
}
let allowed = hook.perform(key: .nameAllowedKey, argument: "ConclurerHook") ?? true
```

## SerialHook

A ``SerialHook``supports multiple closures per ``HookKey``, but ``add(key:, closure:)`` returns an optional reference to be stored in a strong reference.

```swift
var hook = SerialHook<RepositoryAction>()
var updateObject = hook.add(key: .nameChangedKey) { name in /*update title*/ }
var update2Object = hook.add(key: .nameChangedKey) { name in /*update title in another place*/ }
hook.perform(key: nameChangedKey, "NewName")
updateObject = nil // removes the first name changed closure
```

# License
``ConclurerHook`` is released unter [MIT License](./LICENSE).
