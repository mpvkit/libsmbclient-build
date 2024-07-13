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

        .binaryTarget(
            name: "Libsmbclient",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient.xcframework.zip",
            checksum: "a77ac8abdbb4d7ede1fd862338c7b5a0c8bc5d8d2d17c59672d6050afb810923"
        ),
        .binaryTarget(
            name: "Libsmbclient-ios",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-ios.xcframework.zip",
            checksum: "ee69d8c43826bf92203233489c99e1217a83336586d47c321287f43173107801"
        ),
        .binaryTarget(
            name: "Libsmbclient-tvos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-tvos.xcframework.zip",
            checksum: "e19b70479574a84dbc5238410ff063979eddae391e62673c9f949617bbc92cd1"
        ),
        .binaryTarget(
            name: "Libsmbclient-macos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-macos.xcframework.zip",
            checksum: "4ffe6d26dc8e0032007421d01d12c861a035c99401b2cdd9ed626f179c5d83a7"
        ),
        //DEPENDENCY_TARGETS_END//
    ]
)
