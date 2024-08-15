
import UIKit

class OperationCardRulesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 0
        self.backgroundColor = UIColor(named: "Mask")!
        
        /// 主视图
        let imgvBack = UIImageView()
        imgvBack.image = .init(named: "OperationRulesBack")
        self.addSubview(imgvBack)
        imgvBack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.65) // 1733 × 943
            make.height.equalTo(imgvBack.snp.width).multipliedBy(943.0 / 1733.0)
        }
        
        /// 标题 695 × 85
        let imgvTitle = UILabel()
        imgvTitle.textColor = .white
        imgvTitle.font = .systemFont(ofSize: 18, weight: .bold)
        imgvTitle.text = "GAME RULES"
        imgvTitle.textAlignment = .center
        self.addSubview(imgvTitle)
        imgvTitle.snp.makeConstraints { make in
            make.centerX.equalTo(imgvBack)
            make.top.equalTo(imgvBack).offset(15)
        }
        
        // UIScrollView
        let scView = UIScrollView()
        self.addSubview(scView)
        scView.snp.makeConstraints { make in
            make.left.equalTo(imgvBack).offset(50)
            make.right.equalTo(imgvBack).offset(-50)
            make.top.equalTo(imgvTitle.snp.bottom).offset(20)
        }
        
        /// 消息
        let labelMessage = UILabel()
        labelMessage.textColor = .white
        labelMessage.font = .systemFont(ofSize: 20)
        labelMessage.numberOfLines = 0
        labelMessage.text = "The game rules are as follows:\n\n\t1. In simple difficulty, only one calculation symbol is involved, while in difficult difficulty, it tests your intelligence and increases to two calculation symbols.\n\n\t2. There is at least one correct card combination, but there are usually multiple possibilities waiting for you to discover.\n\n\t3. As long as the calculation result of the card combination you choose matches the result provided by the system, you can smoothly enter the next round of the game.\n\n\t4. If you are currently unable to find a suitable card combination, don't worry, click the refresh button to start a new game challenge."
        scView.addSubview(labelMessage)
        labelMessage.snp.makeConstraints { make in
            make.width.equalTo(scView)
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        }
        
        // 关闭按钮 486 × 161
        let btnClose = UIButton()
        btnClose.setTitle("GOT IT", for: .normal)
        btnClose.setTitleColor(.white, for: .normal)
        btnClose.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btnClose.setBackgroundImage(.init(named: "OperationRulesBtnBack"), for: .normal)
        btnClose.addTarget(self, action: #selector(self.btnCloseClick(sender:)), for: .touchUpInside)
        self.addSubview(btnClose)
        btnClose.snp.makeConstraints { make in
            make.top.equalTo(scView.snp.bottom).offset(10)
            make.left.equalTo(imgvBack).offset(40)
            make.bottom.equalTo(imgvBack).offset(-30)
            make.width.equalTo(imgvBack).multipliedBy(0.25)
            make.height.equalTo(btnClose.snp.width).multipliedBy(161.0 / 486.0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 添加显示动画
        if self.alpha == 0 {
            UIView.animate(withDuration: 0.25) {
                self.alpha = 1
                
            }
        }
    }
    
    /// 点击事件
    @objc private func btnCloseClick(sender: UIButton) {
        self.removeFromSuperview()
    }

}

//游戏规则如下：
//﻿
//1、在简单难度下，仅涉及一个计算符号，而困难难度则考验您的智慧，增加至两个计算符号。
//2、正确的卡牌组合至少存在一种，但通常会有多种可能性等待您去发掘。
//3、只要您选择的卡牌组合计算结果与系统给出的结果相吻合，即可顺利进入下一轮游戏。
//4、若您暂时无法找到合适的卡牌组合，无需担忧，点击刷新按钮即可开启新的游戏挑战。
