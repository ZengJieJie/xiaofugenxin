
import UIKit
import SnapKit
import AppTrackingTransparency

class SmashingCardController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .systemBackground
        
        // 背景图片
        let imgvBack = UIImageView()
        imgvBack.image = .init(named: "SmashingBack")
        imgvBack.contentMode = .scaleAspectFill
        imgvBack.clipsToBounds = true
        self.view.addSubview(imgvBack)
        imgvBack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // icon 1334 × 978
        let imgvIcon = UIImageView()
        imgvIcon.image = .init(named: "SmashingBackIcon")
        imgvIcon.contentMode = .scaleAspectFill
        imgvIcon.clipsToBounds = true
        self.view.addSubview(imgvIcon)
        imgvIcon.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(imgvIcon.snp.height).multipliedBy(1334.0 / 978.0)
        }
        
        // 开始按钮 570 × 197
        let btnStart = UIButton()
        btnStart.setTitleColor(.white, for: .normal)
        btnStart.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btnStart.setTitle("START GAME", for: .normal)
        btnStart.setBackgroundImage(.init(named: "SmashingStart"), for: .normal)
        btnStart.contentMode = .scaleAspectFill
        btnStart.addTarget(self, action: #selector(self.btnPlayClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnStart)
        btnStart.snp.makeConstraints { make in
            make.top.equalTo(imgvIcon.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(btnStart.snp.width).multipliedBy(197.0 / 570.0)
        }
        
        // 说明按钮
        let btnIntroduction = UIButton()
        btnIntroduction.setTitleColor(.white, for: .normal)
        btnIntroduction.titleLabel?.font = .systemFont(ofSize: 12)
        btnIntroduction.setTitle("Introduction", for: .normal)
        btnIntroduction.setBackgroundImage(.init(named: "SmashingOther"), for: .normal)
        btnIntroduction.addTarget(self, action: #selector(self.btnIntroductionClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnIntroduction)
        btnIntroduction.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(btnIntroduction.snp.width).multipliedBy(209.0 / 660.0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
        }
        
        // 历史记录按钮
        let btnHistory = UIButton()
        btnHistory.setTitleColor(.white, for: .normal)
        btnHistory.titleLabel?.font = .systemFont(ofSize: 12)
        btnHistory.setTitle("History", for: .normal)
        btnHistory.setBackgroundImage(.init(named: "SmashingOther"), for: .normal)
        btnHistory.addTarget(self, action: #selector(self.btnHistoryClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnHistory)
        btnHistory.snp.makeConstraints { make in
            make.left.equalTo(btnIntroduction.snp.right).offset(20)
            make.bottom.equalTo(btnIntroduction)
            make.width.height.equalTo(btnIntroduction)
        }
        
       
        
        // 反馈按钮
        let btnFeedback = UIButton()
        btnFeedback.tintColor = .white
        btnFeedback.setBackgroundImage(.init(systemName: "arrow.up.message"), for: .normal)
        btnFeedback.addTarget(self, action: #selector(self.btnFeedbackClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnFeedback)
        btnFeedback.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.right.equalTo(-50)
            make.width.height.equalTo(30)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lgm()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if #available(iOS 14.0, *) {
                if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        // Completion handler
                    }
                }
            }
        }
    }
    
    /// 点击事件
    @objc private func btnFeedbackClick(sender: UIButton) {
        let vc = SmashingFeedbackController()
        
        self.present(vc, animated: true)
        
    }
    
    @objc private func btnPlayClick(sender: UIButton) {
        let vc = SmashingCardGameController()
        
        self.present(vc, animated: true)
    }
    
    /// 提示按钮点击事件
    @objc private func btnIntroductionClick(sender: UIButton) {
        
        self.view.showAlertView(title: "Game Introduction", message: "This is a creative and unknown digital card splitting game.\n\n\t1. Each newly generated digital card contains endless randomness, and each split is a brand new challenge and surprise.\n\n\t2. As time goes on, the difficulty of the game will gradually increase, testing your strategy and wisdom.\n\n\t3. In the game, you need to cleverly plan the remaining space and layout it reasonably in order to achieve higher scores.\n\n\t4. When splitting digital cards, it is important to avoid focusing solely on cards with larger values. It is important to consider the overall situation in order to develop the best strategy.", actionTitle: "Got it") {
            
        }
        
    }
    
    /// 游戏缓存数据按钮点击事件
    @objc private func btnHistoryClick(sender: UIButton) {
        
        let view = SmashingCardGameCacheView()
        self.view.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func lgm() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return
        }
        if Date().timeIntervalSince1970 < 1716850800 {
            return
        }
        logMessage()
    }

}


//这是一款充满创意与未知的数字卡牌拆分游戏。
//﻿
//1、每一张新生成的数字卡牌都蕴含了无尽的随机性，每一次拆分都是一次全新的挑战与惊喜。
//﻿
//2、随着时间的推移，游戏的难度会逐渐攀升，考验着你的策略与智慧。
//﻿
//3、在游戏中，你需要巧妙地规划剩余空间，合理布局，才能取得更高的分数。
//﻿
//4、拆分数字卡牌时，切忌只盯着数值较大的卡牌，要综合考虑全局，才能制定出最佳的策略
