// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "bledemoswift",
    products: [
        .library(name: "bledemoswift", type: .dynamic, targets: ["bledemoswifttarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("9bfac47357c4561dafe649c3113c0b67ce5ae36f"))
    ],
    targets: [
        .target(
            name: "bledemoswifttarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
