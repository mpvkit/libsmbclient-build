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
        //AUTO_GENERATE_TARGETS_END//
    ]
)
