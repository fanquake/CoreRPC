// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "CoreRPC",
    products: [
        .library(name: "CoreRPC", targets: ["CoreRPC"]),
    ],
    targets: [
        .target(name: "CoreRPC"),
        .testTarget(name: "CoreRPCTests", dependencies: ["CoreRPC"]),
    ]
)
