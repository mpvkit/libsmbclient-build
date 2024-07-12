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
    exit(0)
}


enum Library: String, CaseIterable {
    case libsmbclient, readline, gnutls, gmp, nettle
    var version: String {
        switch self {
        case .libsmbclient:
            return "samba-4.15.13"
        case .readline:
            return "readline-8.2"
        case .nettle:
            return "3.8.3"
        case .gmp:
            return "3.8.3"
        case .gnutls:
            return "3.8.3"
        }
    }

    var url: String {
        switch self {
        case .libsmbclient:
            return "https://github.com/samba-team/samba"
        case .readline:
            return "https://git.savannah.gnu.org/git/readline.git"
        case .nettle:
            return "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/nettle-all.zip"
        case .gmp:
            return "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/gmp-all.zip"
        case .gnutls:
            return "https://github.com/mpvkit/gnutls-build/releases/download/\(self.version)/gnutls-all.zip"
        }
    }
}


private class BuildSmbclient: BaseBuild {

    init() {
        // // if use brew version python, you will need to install python-setuptools for distutils dependency error
        // if Utility.shell("brew list python-setuptools") == nil {
        //     Utility.shell("brew install python-setuptools")
        // }

        // install setuptools for distutils dependency
        if Utility.shell("python -m pip list|grep setuptools") == nil {
            Utility.shell("python -m pip install setuptools")
        }

        super.init(library: .libsmbclient)
    }

    override func wafPath() -> String {
        "buildtools/bin/waf"
    }

    override func cFlags(platform: PlatformType, arch: ArchType) -> [String] {
        var cFlags = super.cFlags(platform: platform, arch: arch)
        cFlags.append("-Wno-error=implicit-function-declaration")
        return cFlags
    }

    override func environment(platform: PlatformType, arch: ArchType) -> [String: String] {
        var env = super.environment(platform: platform, arch: arch)
        let executableArchitecture = arch.executableArchitecture ?? "x86_64"
        let asn1DirectoryURL = URL.currentDirectory + ["../bin", executableArchitecture]
        env["PATH"] = asn1DirectoryURL.path + ":" + (directoryURL + "buildtools/bin").path + ":/Library/Frameworks/Python.framework/Versions/Current/bin:" + (env["PATH"] ?? "")
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
        [
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

            "--cross-compile",
            "--cross-answers=cross-answers.txt",
        ]
    }

}


private class BuildReadline: BaseBuild {
    init() {
        super.init(library: .readline)
    }

    // readline 只是在编译的时候需要用到。外面不需要用到
    override func frameworks() throws -> [String] {
        []
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        [
            "--enable-static",
            "--disable-shared",
            "--host=\(platform.host(arch: arch))",
            "--prefix=\(thinDir(platform: platform, arch: arch).path)",
        ]
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
