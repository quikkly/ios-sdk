// swift-tools-version:5.3
import PackageDescription
let package = Package(
    name: "Quikkly",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Quikkly", 
            targets: ["Quikkly"])
    ],
    targets: [
        .binaryTarget(
            name: "Quikkly", 
            path: "Quikkly.xcframework")
    ])
