// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftdemo",
    products: [
        .library(name: "swiftdemo", type: .dynamic, targets: ["swiftdemotarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("fb2cf2342cc844cb12be5cefe92d27c641490c32"))
    ],
    targets: [
        .target(
            name: "swiftdemotarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
