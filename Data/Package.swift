// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Data",
            targets: ["Repositories"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "Common",
               dependencies: ["Domain"]),
        .target(name: "Network",
               dependencies: ["Common"]),
        .target(name: "Local",
               dependencies: ["Common"]),
        .target(name: "Repositories",
               dependencies: ["Domain", "Network", "Common", "Local"]),
        .testTarget(
            name: "DataTests",
            dependencies: []),
    ]
)
