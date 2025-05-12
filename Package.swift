// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AmpleDependency",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AmpleDependency",
            targets: [
                "AmpleDependency"
            ])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AmpleDependency",
            dependencies: []),
        .testTarget(
            name: "AmpleDependencyTests",
            dependencies: [
                .target(
                    name: "AmpleDependency")
            ]
        ),
    ]
)
