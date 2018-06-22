// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftandroid",
    products: [
        .library(name: "swiftandroid", type: .dynamic, targets: ["swiftandroid"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("ecac0b9d645a99e053934e3e0efe36fae6dbb700"))
    ],
    targets: [
        .target(
            name: "swiftandroid",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
