import Foundation

do {
    let options = try ArgumentOptions.parse(CommandLine.arguments)
    try Build.performCommand(options)

    try BuildReadline().buildALL()
    try BuildGmp().buildALL()
    try BuildNettle().buildALL()
    try BuildGnutls().buildALL()
    try BuildSmbclient().buildALL()
} catch {
    print(error.localizedDescription)
    exit(1)
}


enum Library: String, CaseIterable {
    case libsmbclient, readline, gnutls, gmp, nettle
    var version: String {
        switch self {
        case .libsmbclient:
            return "samba-4.15.13"
        case .readline:
            return "8.2.0"
        case .nettle:
            return "3.8.6"
        case .gmp:
            return "3.8.6"
        case .gnutls:
            return "3.8.6"
        }
    }

    var url: String {
        switch self {
        case .libsmbclient:
            return "https://github.com/samba-team/samba"
        case .readline:
            return "https://github.com/mpvkit/readline-build/releases/download/\(self.version)/readline-all.zip"
        case .nettle:
            return "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/nettle-all.zip"
        case .gmp:
            return "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/gmp-all.zip"
        case .gnutls:
            return "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/gnutls-all.zip"
        }
    }


    // for generate Package.swift
    var targets : [PackageTarget] {
        switch self {
        case .libsmbclient:
            return  [
                .target(
                    name: "Libsmbclient",
                    url: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient.xcframework.zip",
                    checksum: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient.xcframework.checksum.txt"
                ),
                .target(
                    name: "Libsmbclient-ios",
                    url: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient-ios.xcframework.zip",
                    checksum: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient-ios.xcframework.checksum.txt"
                ),
                .target(
                    name: "Libsmbclient-tvos",
                    url: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient-tvos.xcframework.zip",
                    checksum: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient-tvos.xcframework.checksum.txt"
                ),
                .target(
                    name: "Libsmbclient-macos",
                    url: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient-macos.xcframework.zip",
                    checksum: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient-macos.xcframework.checksum.txt"
                ),
                .target(
                    name: "Libsmbclient-xros",
                    url: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient-xros.xcframework.zip",
                    checksum: "https://github.com/mpvkit/libsmbclient-build/releases/download/\(BaseBuild.options.releaseVersion)/Libsmbclient-xros.xcframework.checksum.txt"
                ),
            ]
        case .gnutls:
            return  [
                .target(
                    name: "gnutls",
                    url: "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/gnutls.xcframework.zip",
                    checksum: "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/gnutls.xcframework.checksum.txt"
                ),
            ]
        case .nettle:
            return  [
                .target(
                    name: "nettle",
                    url: "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/nettle.xcframework.zip",
                    checksum: "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/nettle.xcframework.checksum.txt"
                ),
                .target(
                    name: "hogweed",
                    url: "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/hogweed.xcframework.zip",
                    checksum: "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/hogweed.xcframework.checksum.txt"
                ),
            ]
        case .gmp:
            return  [
                .target(
                    name: "gmp",
                    url: "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/gmp.xcframework.zip",
                    checksum: "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/gmp.xcframework.checksum.txt"
                ),
            ]
        default:
            return []
        }
    }
}


private class BuildSmbclient: BaseBuild {

    init() {
        super.init(library: .libsmbclient)
    }

    override func beforeBuild() throws {
        try super.beforeBuild()

        // // if use brew version python, you will need to install python-setuptools for distutils dependency error
        // if Utility.shell("brew list python-setuptools") == nil {
        //     Utility.shell("brew install python-setuptools")
        // }

        // install setuptools for distutils dependency
        if Utility.shell("python -m pip list|grep setuptools") == nil {
            Utility.shell("python -m pip install setuptools")
        }
    }

    override func flagsDependencelibrarys() -> [Library] {
        [.gmp, .nettle, .gnutls]
    }

    override func wafPath() -> String {
        "buildtools/bin/waf"
    }

    override func cFlags(platform: PlatformType, arch: ArchType) -> [String] {
        var cFlags = super.cFlags(platform: platform, arch: arch)
        cFlags.append("-Wno-error=implicit-function-declaration")
        // cFlags.append("-malign-double")
        // cFlags.append("-Werror=cast-align")
        return cFlags
    }

    override func ldFlags(platform: PlatformType, arch: ArchType) -> [String] {
        var ldFlags = super.ldFlags(platform: platform, arch: arch)

        var path = thinDir(library: .nettle, platform: platform, arch: arch)
        if FileManager.default.fileExists(atPath: path.path) {
            ldFlags.append("-lhogweed")
        }
        path = thinDir(library: .gnutls, platform: platform, arch: arch)
        if FileManager.default.fileExists(atPath: path.path) {
            ldFlags.append(contentsOf: ["-framework", "Security", "-framework", "CoreFoundation"])
        }

        return ldFlags
    }

    override func environment(platform: PlatformType, arch: ArchType) -> [String: String] {
        var env = super.environment(platform: platform, arch: arch)
        let asn1DirectoryURL = URL.currentDirectory + ["../bin", ArchType.hostArch.rawValue]
        env["PATH"] = asn1DirectoryURL.path + ":" + (directoryURL + "buildtools/bin").path + ":" + (env["PATH"] ?? "")
        env["PATH"] = "/Library/Frameworks/Python.framework/Versions/Current/bin:" + (env["PATH"] ?? "") // GIT ACTION python path
        env["PYTHONHASHSEED"] = "1"
        env["WAF_MAKE"] = "1"
        return env
    }

    override func wafBuildArg() -> [String] {
        ["--targets=smbclient"]
    }

    override func wafInstallArg() -> [String] {
        ["--targets=smbclient"]
    }

    override func build(platform: PlatformType, arch: ArchType) throws {
        try super.build(platform: platform, arch: arch)
        try FileManager.default.copyItem(at: directoryURL + "bin/default/source3/libsmb/libsmbclient.a", to: thinDir(platform: platform, arch: arch) + "lib/libsmbclient.a")
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        var options = [
            "--without-cluster-support",
            "--disable-rpath",
            "--without-ldap",
            "--without-pam",
            "--enable-fhs",
            "--without-winbind",
            "--without-ads",
            "--disable-avahi",
            "--disable-cups",
            "--without-gettext",
            "--without-ad-dc",
            "--without-acl-support",
            "--without-utmp",
            "--disable-iprint",
            "--nopyc",
            "--nopyo",
            "--disable-python",
            "--disable-symbol-versions",
            "--without-json",
            "--without-libarchive",
            "--without-regedit",
            "--without-lttng",
            "--without-gpgme",
            "--disable-cephfs",
            "--disable-glusterfs",
            "--without-syslog",
            "--without-quotas",
            "--bundled-libraries=ALL",
            "--with-static-modules=!vfs_snapper,ALL",
            "--nonshared-binary=smbtorture,smbd/smbd,client/smbclient",
            "--builtin-libraries=!smbclient,!smbd_base,!smbstatus,ALL",
            "--host=\(platform.host(arch: arch))",
            "--prefix=\(thinDir(platform: platform, arch: arch).path)",
        ]

        //macOS can detect, but other platforms need configured by cross-answers.txt
        let crossawsersURL = URL.currentDirectory + "../Sources/BuildScripts/waf-cross-answers/\(arch.rawValue).txt"
        if platform != .macos && arch != ArchType.hostArch {
            options += [
                "--cross-compile",
                "--cross-answers=\(crossawsersURL.path)",
            ]
        }

        return options
    }

}


private class BuildReadline: ZipBaseBuild {
    init() {
        super.init(library: .readline)
    }

    // readline 只是在编译的时候需要用到。外面不需要用到
    override func frameworks() throws -> [String] {
        []
    }
}

private class BuildGmp: ZipBaseBuild {
    init() {
        super.init(library: .gmp)
    }
}

private class BuildNettle: ZipBaseBuild {
    init() {
        super.init(library: .nettle)
    }
}

private class BuildGnutls: ZipBaseBuild {
    init() {
        super.init(library: .gnutls)
    }
}
