// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "bledemoswift",
    products: [
        .library(name: "bledemoswift", type: .dynamic, targets: ["bledemoswifttarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("91dfe5dd929101805233f402b2d5a3366c841a88"))
    ],
    targets: [
        .target(
            name: "bledemoswifttarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
