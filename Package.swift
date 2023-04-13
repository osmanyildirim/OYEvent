// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "OYEvent",
    products: [
        .library(name: "OYEvent", targets: ["OYEvent"])
    ],
    targets: [
        .target(name: "OYEvent", path: "Sources")
    ]
)