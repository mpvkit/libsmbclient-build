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
            url: "https://github.com/mpvkit/gnutls-build/releases/download/3.8.8-xcode/gmp.xcframework.zip",
            checksum: "019faab8625fedb38bb934fafb73a547c9cb29ccdeabfd3998256d1ea0760e2c"
        ),

        .binaryTarget(
            name: "nettle",
            url: "https://github.com/mpvkit/gnutls-build/releases/download/3.8.8-xcode/nettle.xcframework.zip",
            checksum: "bd4dbeea46a9abc02797c2f503d79636ee09b8a5f8ed4d2bbe2cc00e29c066cb"
        ),
        .binaryTarget(
            name: "hogweed",
            url: "https://github.com/mpvkit/gnutls-build/releases/download/3.8.8-xcode/hogweed.xcframework.zip",
            checksum: "48c300eadfbe61ab08b56a08fc5b979c84839c8bba665caf6515079949db0cbf"
        ),

        .binaryTarget(
            name: "gnutls",
            url: "https://github.com/mpvkit/gnutls-build/releases/download/3.8.8-xcode/gnutls.xcframework.zip",
            checksum: "8be5568b3bcaa7378e470b6eb2b11f1af86b5d5637229d1d3eb725a2e0c4b9da"
        ),

        .binaryTarget(
            name: "Libsmbclient",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13-xcode/Libsmbclient.xcframework.zip",
            checksum: "eca7ec0f3a226441c051773e2742670c85a2de522957b3580d3ccd65071281e5"
        ),
        .binaryTarget(
            name: "Libsmbclient-ios",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13-xcode/Libsmbclient-ios.xcframework.zip",
            checksum: "25e9777b6753bafb4327930fedc9503bdf4c5b327ca5d325f0f0fd306a4f02a6"
        ),
        .binaryTarget(
            name: "Libsmbclient-tvos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13-xcode/Libsmbclient-tvos.xcframework.zip",
            checksum: "34aee1a2aa57310a7ca2b35919bf5925484bcf1fb5923aa5b111f165739d4154"
        ),
        .binaryTarget(
            name: "Libsmbclient-macos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13-xcode/Libsmbclient-macos.xcframework.zip",
            checksum: "ab73bca86a6b92696b0c31630bc3b3047befc264a159dde7aa4ad72aa8cb871a"
        ),
        .binaryTarget(
            name: "Libsmbclient-xros",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13-xcode/Libsmbclient-xros.xcframework.zip",
            checksum: "084012b0f20b63889929669f576fa8b49e881029ee8bd5c1dc24d9e43ac7cd26"
        ),
        //AUTO_GENERATE_TARGETS_END//
    ]
)
