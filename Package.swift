// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Dependency",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Dependency",
            targets: [
                "Dependency"
            ])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Dependency",
            dependencies: []),
        .testTarget(
            name: "DependencyTests",
            dependencies: [
                .target(
                    name: "Dependency")
            ]
        ),
    ]
)
