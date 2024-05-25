
import UIKit

class SmashingCardAlertView: UIView {
    
    /// 主视图
    let viewMain = UIView()
    /// 标题
    let labelTitle = UILabel()
    /// 消息
    let labelMessage = UILabel()
    /// 按钮组
    let viewButtons = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 0
        self.backgroundColor = .colorMask
        
        viewMain.backgroundColor = .colorCard
        viewMain.uiCornerRadius()
        self.addSubview(viewMain)
        viewMain.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        labelTitle.textColor = .label
        labelTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        labelTitle.textAlignment = .center
        viewMain.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(0)
            make.right.equalTo(-15)
            make.height.equalTo(44)
        }
        
        // 标题分割线
        let viewTitleLine = UIView()
        viewTitleLine.backgroundColor = .colorLine
        viewMain.addSubview(viewTitleLine)
        viewTitleLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(labelTitle)
            make.height.equalTo(1)
        }
        
        // UIScrollView
        let scView = UIScrollView()
        viewMain.addSubview(scView)
        scView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(labelTitle.snp.bottom)
            make.right.equalTo(-10)
        }
        // 消息分割线
        let viewMessageLine = UIView()
        viewMessageLine.backgroundColor = .colorLine
        viewMain.addSubview(viewMessageLine)
        viewMessageLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(scView)
            make.height.equalTo(1)
        }
        labelMessage.textColor = .label
        labelMessage.font = .systemFont(ofSize: 15)
        labelMessage.numberOfLines = 0
        scView.addSubview(labelMessage)
        labelMessage.snp.makeConstraints { make in
            make.width.equalTo(scView)
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        }
        
        viewMain.addSubview(viewButtons)
        viewButtons.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(scView.snp.bottom)
            make.bottom.equalTo(0)
            make.height.equalTo(0)
        }
    }
    
    /// 初始化一个弹框
    convenience init(title: String, message: String, actionTitle: String = "", action: (() ->())? = nil) {
        self.init(frame: CGRect.zero)
        
        self.labelTitle.text = title
        self.labelMessage.text = message
        
        if let action = action {
            self.addAction(title: actionTitle, action: action)
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
    
    /// 按钮事件组
    private var listAction: [() ->()] = []
    /// 添加按钮
    func addAction(title: String, color: UIColor = .systemBlue, action: @escaping (() ->())) {
        let list = self.viewButtons.subviews
        
        if list.count == 0 {
            self.viewButtons.snp.updateConstraints { make in
                make.height.equalTo(44)
            }
        }
        
        for item in list {
            item.snp.removeConstraints()
        }
        
        let btn = UIButton()
        btn.tag = self.listAction.count
        btn.setTitleColor(color, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.setTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
        self.viewButtons.addSubview(btn)
        
        self.listAction.append(action)
        
        btn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1.0 / Float(self.listAction.count))
        }
        
        self.viewButtons.uiLineLayout()
    }

}

extension SmashingCardAlertView {
    
    /// 按钮点击事件
    @objc private func btnClick(sender: UIButton) {
        let action = self.listAction[sender.tag]
        action()
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
            
        } completion: { _ in
            self.removeFromSuperview()
            
        }

    }
    
}
