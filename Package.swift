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
            name: "Libsmbclient_macos",
            targets: ["Libsmbclient_macos"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/mpvkit/gnutls-build.git", from: "3.8.3")
    ],
    targets: [
        .binaryTarget(
            name: "Libsmbclient",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient.xcframework.zip",
            checksum: "41432c74d776535c97a4605c2150cda8fc2fd69eb4b567755a252bd3ea78d53e"
        ),
        .binaryTarget(
            name: "Libsmbclient-ios",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-ios.xcframework.zip",
            checksum: "e8a9b481d07302dd52288d589d09634b3251f68dc812884f33745312f9c56530"
        ),
        .binaryTarget(
            name: "Libsmbclient-tvos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-tvos.xcframework.zip",
            checksum: "bf9e67a85510d7aac47d566282f59982ae1d92fefff61a8f442b6f21b49f21d1"
        ),
        .binaryTarget(
            name: "Libsmbclient_macos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-macos.xcframework.zip",
            checksum: "f0fe69ba45b56054fb3117bef467ded4c036a71e97424cff1b27057f7ce5ef1a"
        )
    ]
)
