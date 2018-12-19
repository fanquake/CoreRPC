// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "CoreRPC",
    products: [
        .library(name: "CoreRPC", targets: ["CoreRPC"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mxcl/PromiseKit", from: "6.7.1"),
        .package(url: "https://github.com/PromiseKit/Foundation", from: "3.3.0")
    ],
    targets: [
        .target(name: "CoreRPC", dependencies: ["PromiseKit", "PMKFoundation"]),
        .testTarget(name: "CoreRPCTests", dependencies: ["CoreRPC"]),
    ]
)
