// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftandroid",
    products: [
        .library(name: "swiftandroid", type: .dynamic, targets: ["swiftandroid"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("fb2cf2342cc844cb12be5cefe92d27c641490c32"))
    ],
    targets: [
        .target(
            name: "swiftandroid",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
