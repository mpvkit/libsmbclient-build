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
            checksum: "e4c0e0e206289ff0d22c896d9b323e7ce719120a4d1900e8f48c43843d280c7a"
        ),
        .binaryTarget(
            name: "Libsmbclient-ios",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-ios.xcframework.zip",
            checksum: "83b04fa841f5467307638514d4c9ce7d4c6ffcbfa897c01c7b4aca2f20bf0023"
        ),
        .binaryTarget(
            name: "Libsmbclient-tvos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-tvos.xcframework.zip",
            checksum: "4e8b3feb637fabeab3ce0192eb0bdee5848148371780aa13948715d88ae84a52"
        ),
        .binaryTarget(
            name: "Libsmbclient_macos",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient-macos.xcframework.zip",
            checksum: "f40d781c02c02783ace67578ab3d5fe25869891e29f98624d88e4dd0cee006a4"
        )
    ]
)
