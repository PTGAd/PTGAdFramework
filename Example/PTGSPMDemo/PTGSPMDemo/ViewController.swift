import UIKit
import PTGAdSDK
import PTGAdSDKResources

final class ViewController: UIViewController {

    private let versionLabel = UILabel()
    private let logoImageView = UIImageView()
    private let resourceLabel = UILabel()
    private let appKeyField = UITextField()
    private let appSecretField = UITextField()
    private let placementField = UITextField()
    private let statusLabel = UILabel()
    private let bannerContainer = UIView()
    private var bannerAd: PTGNativeExpressBannerAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PTGAdFramework SPM Demo"
        view.backgroundColor = .systemBackground
        setupUI()
        showSDKInfo()
    }

    // MARK: - UI

    private func setupUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        versionLabel.font = .preferredFont(forTextStyle: .headline)
        versionLabel.numberOfLines = 0

        logoImageView.contentMode = .scaleAspectFit
        logoImageView.heightAnchor.constraint(equalToConstant: 96).isActive = true

        resourceLabel.font = .preferredFont(forTextStyle: .footnote)
        resourceLabel.textColor = .secondaryLabel
        resourceLabel.numberOfLines = 0

        [appKeyField, appSecretField, placementField].forEach {
            $0.borderStyle = .roundedRect
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            $0.clearButtonMode = .whileEditing
        }
        appKeyField.placeholder = "appKey"
        appSecretField.placeholder = "appSecret"
        placementField.placeholder = "banner 广告位 ID"

        let initButton = UIButton(type: .system)
        initButton.setTitle("初始化 SDK", for: .normal)
        initButton.addTarget(self, action: #selector(initSDK), for: .touchUpInside)

        let loadButton = UIButton(type: .system)
        loadButton.setTitle("加载 Banner", for: .normal)
        loadButton.addTarget(self, action: #selector(loadBanner), for: .touchUpInside)

        let buttons = UIStackView(arrangedSubviews: [initButton, loadButton])
        buttons.axis = .horizontal
        buttons.spacing = 16
        buttons.distribution = .fillEqually

        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        statusLabel.textColor = .secondaryLabel
        statusLabel.numberOfLines = 0
        statusLabel.text = "提示：首次使用请填写 appKey / appSecret 和广告位 ID。"

        bannerContainer.backgroundColor = .secondarySystemBackground
        bannerContainer.layer.cornerRadius = 8
        bannerContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true

        let arrangedViews: [UIView] = [
            versionLabel, logoImageView, resourceLabel,
            appKeyField, appSecretField, placementField,
            buttons, statusLabel, bannerContainer
        ]
        arrangedViews.forEach { stack.addArrangedSubview($0) }

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        scrollView.addSubview(stack)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            stack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    private func showSDKInfo() {
        versionLabel.text = "PTGAdSDK 版本：\(PTGSDKManager.getSDKVersion())"

        guard let bundle = PTGAdSDKResources.sdkBundle else {
            resourceLabel.text = "未找到 PTGAdSDK.bundle"
            return
        }

        if let path = bundle.path(forResource: "reward", ofType: "png") {
            logoImageView.image = UIImage(contentsOfFile: path)
        }
        resourceLabel.text = "资源包加载成功：\(bundle.bundleURL.lastPathComponent)"
        print("[PTGSPMDemo] resource bundle: \(bundle.bundlePath)")
    }

    // MARK: - Actions

    @objc private func initSDK() {
        let appKey = appKeyField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let appSecret = appSecretField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !appKey.isEmpty, !appSecret.isEmpty else {
            showAlert("请先填写 appKey 和 appSecret")
            return
        }

        let success = PTGSDKManager.syncSetAppKey(appKey, appSecret: appSecret)
        statusLabel.text = success ? "SDK 初始化成功" : "SDK 初始化失败"
    }

    @objc private func loadBanner() {
        let placementId = placementField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !placementId.isEmpty else {
            showAlert("请填写 banner 广告位 ID")
            return
        }

        let size = CGSize(width: max(bannerContainer.bounds.width, 300), height: 150)
        let ad = PTGNativeExpressBannerAd(placementId: placementId, size: size)
        ad.delegate = self
        ad.rootViewController = self
        bannerAd = ad
        statusLabel.text = "Banner 加载中…"
        ad.load()
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - PTGNativeExpressBannerAdDelegate

extension ViewController: PTGNativeExpressBannerAdDelegate {

    func ptg_nativeExpressBannerAdDidLoad(_ bannerAd: PTGNativeExpressBannerAd) {
        guard bannerAd.isReady else {
            statusLabel.text = "Banner 已过期"
            return
        }
        bannerAd.show(from: bannerContainer, frame: bannerContainer.bounds)
        statusLabel.text = "Banner 加载成功，size = \(bannerAd.realSize)"
    }

    func ptg_nativeExpressBannerAd(_ bannerAd: PTGNativeExpressBannerAd,
                                  didLoadFailWithError error: Error?) {
        statusLabel.text = "Banner 加载失败：\(error?.localizedDescription ?? "unknown")"
    }

    func ptg_nativeExpressBannerAdClosed(_ bannerAd: PTGNativeExpressBannerAd) {
        statusLabel.text = "Banner 已关闭"
    }
}
