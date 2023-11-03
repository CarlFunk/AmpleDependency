// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Dependency",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Dependency",
            targets: ["Dependency"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Dependency",
            dependencies: [])
    ]
)
