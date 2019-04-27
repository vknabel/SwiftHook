# Changelog

## 3.0.0

*Released: 2019-04-27*

### Breaking Changes

- Upgraded to Swift 5 - @vknabel
- `HookType` is now `Hook` - @vknabel
- `RawHookKeyType` is now `HookAction` - @vknabel
- `HookKey` is now `HookEvent` - @vknabel
- `HookType.performAction(forKey:,with:)` has been renamed to `trigger(event:,with:)` now returns an `Array` instead of `AnySequence` - @vknabel
- `HookType.add(key:,with:)` has been renamed to `respond(to:,with:)` - @vknabel

## 2.0.0

*Released: 2016-09-26*

### Breaking Changes

- Upgraded to Swift 3.0.0 - @vknabel
- Renamed `HookType.add(_:,closure:)` to `HookType.add(key:,with:)` - @vknabel
- Renamed `HookType.perform(_:,argument:)` to `HookType.performAction(forKey:,with:)` - @vknabel

### API Additions

- Added Cocoapods support - @vknabel
- Added generated Jazzy docs - @vknabel
- Added Travis support - @vknabel

### Other Changes

- Regenerated Xcode Project - @vknabel
- Renamed remaining `ConclurerHook` references - @vknabel
- Introduced Changelog - @vknabel
