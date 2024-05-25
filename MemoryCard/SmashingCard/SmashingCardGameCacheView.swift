
import UIKit

// 2048卡牌游戏缓存列表弹窗视图
class SmashingCardGameCacheView: UIView {
    
    /// 数据源
    private var listData = SmashingCardGameCacheModel.loadSmashingCardGameCacheListFromJSONFile() ?? []
    
    /// 数据列表
    private let tableView = UITableView(frame: CGRect(), style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 0
        self.backgroundColor = .colorMask
        
        // 主视图
        let viewMain = UIView()
        viewMain.backgroundColor = .colorCard
        viewMain.uiCornerRadius()
        self.addSubview(viewMain)
        viewMain.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        // 标题
        let labelTitle = UILabel()
        labelTitle.textColor = .label
        labelTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        labelTitle.text = "Game History"
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
        
        // 表格
        tableView.backgroundColor = .colorCard
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UITableViewCell.self)
        viewMain.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(labelTitle.snp.bottom)
            make.right.equalTo(-10)
        }
        // 消息分割线
        let viewMessageLine = UIView()
        viewMessageLine.backgroundColor = .colorLine
        viewMain.addSubview(viewMessageLine)
        viewMessageLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom)
            make.height.equalTo(1)
        }
        
        // 关闭按钮
        let btn = UIButton()
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.setTitle("Close", for: .normal)
        btn.addTarget(self, action: #selector(self.btnClick(sender:)), for: .touchUpInside)
        viewMain.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viewMessageLine.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalTo(0)
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
    
    /// 按钮点击事件
    @objc private func btnClick(sender: UIButton) {
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
            
        } completion: { _ in
            self.removeFromSuperview()
            
        }

    }

}

extension SmashingCardGameCacheView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.listData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(UITableViewCell.self, indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)\tClickCount: \(model.clickCount)        TotalScore: \(model.totalScore)        Date: \(model.time)"
        
        return cell
    }
}
