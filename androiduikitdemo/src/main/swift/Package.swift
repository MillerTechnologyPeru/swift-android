// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "androiduikit",
    products: [
        .library(name: "androiduikit", type: .dynamic, targets: ["androiduikit"]),
        ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("becd2aebfa3f0f3162b3a8cdf646fa3142998d8d"))
    ],
    targets: [
        .target(
            name: "androiduikit",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
