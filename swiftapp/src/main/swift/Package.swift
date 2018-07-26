// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftapp",
    products: [
        .library(name: "swiftapp", type: .dynamic, targets: ["swiftapptarget"]),
    ],
    dependencies: [
        //.package(url: "git@github.com:PureSwift/Android.git", .revision("4d1c40b5e1e44314688e4635e544254763faec04"))
        .package(url: "git@github.com:PureSwift/Android.git", .branch("feature/ViewGroup"))
    ],
    targets: [
        .target(
            name: "swiftapptarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
