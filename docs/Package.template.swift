// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "libsmbclient",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13)],
    products: [
        .library(
            name: "Libsmbclient",
            targets: ["Libsmbclient"]
        ),
        .library(
            name: "Libsmbclient-ios",
            targets: ["Libsmbclient-ios"]
        ),
        .library(
            name: "Libsmbclient-tvos",
            targets: ["Libsmbclient-tvos"]
        ),
        .library(
            name: "Libsmbclient-macos",
            targets: ["Libsmbclient-macos"]
        ),
    ],
    targets: [
        //DEPENDENCY_TARGETS_BEGIN//
        //DEPENDENCY_TARGETS_END//
    ]
)
