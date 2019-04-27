// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SwiftHook",
    targets: [
        .target(name: "SwiftHook"),
        .testTarget(name: "SwiftHookTests", dependencies: ["SwiftHook"]),
    ]
)
