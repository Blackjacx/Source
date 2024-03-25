// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "Source",
    platforms: [
        // .macOS(.v10_12),
        .iOS(.v14),
        // .tvOS(.v10),
        // .watchOS(.v3)
    ],
    products: [
        .library(name: "Source", targets: ["Source"])
    ],
    targets: [
        .target(name: "Source", path: "Source")
    ],
    swiftLanguageVersions: [.v5]
)
