// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PTGAdFramework",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "PTGAdFramework",
            targets: ["PTGAdSDK", "PTGAdSDKResources"]
        )
    ],
    targets: [
        // 二进制 SDK，直接使用仓库里的 xcframework。
        // 如果希望把二进制放到独立地址（例如 GitHub Release），
        // 可以改成 .binaryTarget(name:url:checksum:) 并填入 zip 的 checksum。
        .binaryTarget(
            name: "PTGAdSDK",
            path: "Frameworks/PTGAdSDK.xcframework"
        ),

        // 资源 target。
        // SwiftPM 的 binaryTarget 不能声明 resources，所以用一个资源 target
        // 把 Frameworks/PTGAdSDK.bundle 打进 <PackageName>_PTGAdSDKResources.bundle，
        // 同时负责链接 SDK 依赖的系统框架/库。
        // 这个 target 需要至少一个源文件供 Xcode 编译；PTGAdSDKResources.swift
        // 只暴露 Bundle.module，SDK 内部仍会自己查找 bundle。
        .target(
            name: "PTGAdSDKResources",
            dependencies: ["PTGAdSDK"],
            path: "Frameworks",
            exclude: ["PTGAdSDK.xcframework", ".DS_Store"],
            sources: ["PTGAdSDKResources"],
            resources: [
                .copy("PTGAdSDK.bundle"),
                .copy("PrivacyInfo.xcprivacy")
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("MapKit"),
                .linkedFramework("WebKit"),
                .linkedFramework("MediaPlayer"),
                .linkedFramework("AdSupport"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("MobileCoreServices"),
                .linkedFramework("CoreMotion"),
                .linkedFramework("Accelerate"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("Security"),
                .linkedLibrary("c++"),
                .linkedLibrary("resolv"),
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3")
            ]
        )
    ]
)
