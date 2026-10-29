import Foundation

/// SwiftPM 资源 target 的公开入口。
///
/// SDK 内部会自己查找资源包，这里的 API 主要方便业务方或示例工程
/// 直接读取 `PTGAdSDK.bundle` 里的图片等资源。
public enum PTGAdSDKResources {

    /// SwiftPM 生成的资源包（`PTGAdFramework_PTGAdSDKResources.bundle`）。
    public static var wrapperBundle: Bundle {
        Bundle.module
    }

    /// SDK 的 `PTGAdSDK.bundle`，包含广告展示所需的图片资源。
    public static var sdkBundle: Bundle? {
        guard let url = Bundle.module.url(forResource: "PTGAdSDK", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: url)
    }
}
