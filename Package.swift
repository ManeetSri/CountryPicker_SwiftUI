// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CountryPicker_SwiftUI",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "CountryPicker_SwiftUI",
            targets: ["CountryPicker_SwiftUI"]
        ),
    ],
    targets: [
        .target(
            name: "CountryPicker_SwiftUI",
            resources: [
                .process("Resource")
            ]
        ),
        .testTarget(
            name: "CountryPicker_SwiftUITests",
            dependencies: ["CountryPicker_SwiftUI"]
        ),
    ]
)
