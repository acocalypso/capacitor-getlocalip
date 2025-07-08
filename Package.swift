// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorGetlocalip",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorGetlocalip",
            targets: ["GetLocalIPPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "GetLocalIPPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/GetLocalIPPlugin"),
        .testTarget(
            name: "GetLocalIPPluginTests",
            dependencies: ["GetLocalIPPlugin"],
            path: "ios/Tests/GetLocalIPPluginTests")
    ]
)