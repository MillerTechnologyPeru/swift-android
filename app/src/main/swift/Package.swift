// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftandroid",
    products: [
        .library(name: "swiftandroid", type: .dynamic, targets: ["swiftandroid"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("535a81faf9e9ef2b9edd66c4e285c8dfbd270e6b"))
    ],
    targets: [
        .target(
            name: "swiftandroid",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
