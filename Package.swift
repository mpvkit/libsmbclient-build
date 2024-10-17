// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "libsmbclient",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13)],
    products: [
        .library(
            name: "Libsmbclient",
            targets: ["_Libsmbclient"]
        ),
        .library(
            name: "Libsmbclient-ios",
            targets: ["_Libsmbclient-ios"]
        ),
        .library(
            name: "Libsmbclient-tvos",
            targets: ["_Libsmbclient-tvos"]
        ),
        .library(
            name: "Libsmbclient-macos",
            targets: ["_Libsmbclient-macos"]
        ),
        .library(
            name: "Libsmbclient-xros",
            targets: ["_Libsmbclient-xros"]
        ),
    ],
    targets: [
        // Need a dummy target to embedded correctly.
        // https://github.com/apple/swift-package-manager/issues/6069
        .target(
            name: "_Libsmbclient",
            dependencies: ["gmp", "nettle", "hogweed", "gnutls", "Libsmbclient"],
            path: "Sources/_Libsmbclient"
        ),
        .target(
            name: "_Libsmbclient-ios",
            dependencies: ["gmp", "nettle", "hogweed", "gnutls", "Libsmbclient-ios"],
            path: "Sources/_Libsmbclient-ios"
        ),
        .target(
            name: "_Libsmbclient-tvos",
            dependencies: ["gmp", "nettle", "hogweed", "gnutls", "Libsmbclient-tvos"],
            path: "Sources/_Libsmbclient-tvos"
        ),
        .target(
            name: "_Libsmbclient-macos",
            dependencies: ["gmp", "nettle", "hogweed", "gnutls", "Libsmbclient-macos"],
            path: "Sources/_Libsmbclient-macos"
        ),
        .target(
            name: "_Libsmbclient-xros",
            dependencies: ["gmp", "nettle", "hogweed", "gnutls", "Libsmbclient-xros"],
            path: "Sources/_Libsmbclient-xros"
        ),
        //AUTO_GENERATE_TARGETS_BEGIN//

        .binaryTarget(
            name: "gmp",
            url: "https://github.com/mpvkit/gnutls-build/releases/download/3.8.6/gmp.xcframework.zip",
            checksum: "3778324f9f0eb3612eff3cf40184b99c13ba59c9715d5b1cb1b4fed2a6e9d986"
        ),

        .binaryTarget(
            name: "nettle",
            url: "https://github.com/mpvkit/gnutls-build/releases/download/3.8.6/nettle.xcframework.zip",
            checksum: "5896222340532fe813f889baa33fe36e701ea7bf771c3bb4b2a8c92609718d0b"
        ),
        .binaryTarget(
            name: "hogweed",
            url: "https://github.com/mpvkit/gnutls-build/releases/download/3.8.6/hogweed.xcframework.zip",
            checksum: "1803b8d70321419026b357ea1a32c208808cc5deea5f2a2fbb1caaff53b72ef3"
        ),

        .binaryTarget(
            name: "gnutls",
            url: "https://github.com/mpvkit/gnutls-build/releases/download/3.8.6/gnutls.xcframework.zip",
            checksum: "1a09c17f4c7ff96d74062def690ff5ed21f9e28f0f096d1c4d1427247fbc76e8"
        ),

        .binaryTarget(
            name: "Libsmbclient",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.6/Libsmbclient.xcframework.zip",
            checksum: "842dfe8e75696c233278ca163ccb08a5327d3cf37f286bc4c01eedfc26a5a984"
        ),
        .binaryTarget(
            name: "Libsmbclient-ios",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.6/Libsmbclient-ios.xcframework.zip",
            checksum: "4a0ebf1a79a127b3143e0a9b9742555c9dae6866cffeb5a0c8238dcbc926e699"
        ),
        .binaryTarget(
            name: "Libsmbclient-tvos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.6/Libsmbclient-tvos.xcframework.zip",
            checksum: "0349ff665e79dd7f610b7b084877a3e3c1ee085475549b71089cb32580531105"
        ),
        .binaryTarget(
            name: "Libsmbclient-macos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.6/Libsmbclient-macos.xcframework.zip",
            checksum: "173f72e104ab5af2ea592dd5f30e711147dd8e9f172fa3907ebc2a4be0f21b4a"
        ),
        .binaryTarget(
            name: "Libsmbclient-xros",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.6/Libsmbclient-xros.xcframework.zip",
            checksum: "5496f971070b4deb0275cd902aa9e14153cc83ff156bec4f5cbf71b783f78b01"
        ),
        //AUTO_GENERATE_TARGETS_END//
    ]
)
