// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftdemo",
    products: [
        .library(name: "swiftdemo", type: .dynamic, targets: ["swiftdemotarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("8d06dc44a84d774da66afeb2caecbf31e36fd6fc"))
    ],
    targets: [
        .target(
            name: "swiftdemotarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
