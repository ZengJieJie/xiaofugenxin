
import UIKit

// 2048卡牌游戏控制器
class SmashingCardGameController: UIViewController {
    
    /// 排几行
    private let rowCount: CGFloat = 4
    /// 排几列
    private let colCount: CGFloat = 8
    /// 点击次数
    private var clickCount = 0
    /// 总分
    private var totalScore = 0
    /// 新卡牌概率数组，小数字的概率应该要大一些，不然游戏一会就结束了
    private let listNew = SmashingCardGameData.initListData()
    
    ///适配safeArea
    private lazy var viewBase : UIView = { () -> UIView in
        var view = UIView()
        self.view.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        return view
    }()
    /// 主视图
    private let viewMain = UIView()
    /// 点击次数
    private let labelClickCount = UILabel()
    /// 得分
    private let labelTotalScore = UILabel()
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .systemBackground
        
        // 背景图片
        let imgvBack = UIImageView()
        imgvBack.image = .init(named: "SmashingGameBack")
        imgvBack.contentMode = .scaleAspectFill
        imgvBack.clipsToBounds = true
        self.view.addSubview(imgvBack)
        imgvBack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 关闭按钮
        let btnClose = UIButton()
        btnClose.setBackgroundImage(.init(named: "SmashingClose"), for: .normal)
        btnClose.addTarget(self, action: #selector(self.btnCloseClick(sender:)), for: .touchUpInside)
        viewBase.addSubview(btnClose)
        btnClose.snp.makeConstraints { make in
            make.top.equalTo(35)
            make.right.equalTo(-15)
            make.height.width.equalTo(50)
        }
        
        let height = Mts.SH - 140
        let itemHeight = height / self.rowCount
        
        let itemWidth = itemHeight * 173.0 / 225.0 // 173 × 225
        let width = itemWidth * self.colCount
        
//        viewMain.backgroundColor = .hex("#44060e", alpha: 0.5)
        viewMain.uiCornerRadius(8)
        viewBase.addSubview(viewMain)
        viewMain.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview().offset(10)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        // 主视图背景
        let imgvMainBack = UIImageView()
        imgvMainBack.image = .init(named: "SmashingGameMainBack")
        imgvMainBack.contentMode = .scaleToFill
        imgvMainBack.clipsToBounds = true
        viewBase.insertSubview(imgvMainBack, at: 0)
        imgvMainBack.snp.makeConstraints { make in
            make.left.equalTo(viewMain).offset(-15)
            make.right.equalTo(viewMain).offset(15)
            make.top.equalTo(viewMain).offset(-15)
            make.bottom.equalTo(viewMain).offset(15)
        }
        
        // 初始化数据和UI
        var x: CGFloat = 0
        var y: CGFloat = 0
        let count = Int(self.rowCount * self.colCount) - 1
        for index in 0...count {
            let frame = CGRect(x: x, y: y, width: itemWidth, height: itemHeight)
            
            let view = SmashingCardGameView(frame: frame)
            view.tag = index
            view.currentFrame = frame
            view.addTarget(self, action: #selector(self.btnItemClick(gameView:)), for: .touchUpInside)
            viewMain.addSubview(view)
            
            x = x + itemWidth
            if (index != 0 && (index+1) % Int(self.colCount) == 0) {
                y = y + itemHeight
                x = 0
            }
        }
        
        self.initRandom()
        
        // 点击次数背景 788 × 172
        let imgvCount = UIImageView()
        imgvCount.image = .init(named: "SmashingGameCountBack")
        imgvCount.contentMode = .scaleToFill
        imgvCount.clipsToBounds = true
        viewBase.addSubview(imgvCount)
        imgvCount.snp.makeConstraints { make in
            make.top.equalTo(btnClose.snp.bottom).offset(40)
            make.right.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(imgvCount.snp.width).multipliedBy(172.0 / 788.0)
        }
        
        labelClickCount.textColor = .white
        labelClickCount.font = .systemFont(ofSize: 20, weight: .bold)
        labelClickCount.text = "Split Count: 0"
        labelClickCount.textAlignment = .center
        imgvCount.addSubview(labelClickCount)
        labelClickCount.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 点击次数背景 788 × 172
        let imgvScore = UIImageView()
        imgvScore.image = .init(named: "SmashingGameCountBack")
        imgvScore.contentMode = .scaleToFill
        imgvScore.clipsToBounds = true
        viewBase.addSubview(imgvScore)
        imgvScore.snp.makeConstraints { make in
            make.top.equalTo(imgvCount.snp.bottom).offset(20)
            make.right.equalToSuperview()
            make.width.height.equalTo(imgvCount)
        }
        
        labelTotalScore.textColor = .white
        labelTotalScore.font = .systemFont(ofSize: 20, weight: .bold)
        labelTotalScore.text = "Current Score: 0"
        labelTotalScore.textAlignment = .center
        imgvScore.addSubview(labelTotalScore)
        labelTotalScore.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}

extension SmashingCardGameController {
    
    /// 关闭按钮点击事件
    @objc private func btnCloseClick(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /// 游戏结束
    private func gameDone() {
        // 缓存游戏数据
        let model = SmashingCardGameCacheModel(clickCount: self.clickCount, totalScore: self.totalScore)
        model.cacheData()
        
        let alertVC = UIAlertController(title: "Game Over", message: "There's no more space left", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let weakSelf = self else { return }
            
            weakSelf.dismiss(animated: true)
        }
        alertVC.addAction(action)
        
        self.present(alertVC, animated: true)
    }
    
    /// 更新分数和点击次数UI
    private func updateScoreUI() {
        labelClickCount.text = "Split Count: \(self.clickCount)"
        labelTotalScore.text = "Current Score: \(self.totalScore)"
    }
    
    /// 卡牌点击事件
    @objc private func btnItemClick(gameView: SmashingCardGameView) {
        
        // 小于4的卡牌不能点击
        if gameView.cradNumber < 4 {
            return
        }
        
        self.clickCount += 1
        self.updateScoreUI()
        
        guard let listView = self.viewMain.subviews as? [SmashingCardGameView] else { return }
        
        // 取出所有空位
        let list = listView.filter({ $0.cradNumber == 0 })
        // 随机定位一个位置
        let index = Int.random(in: 0...(list.count - 1))
        // 新的卡牌数值
        let number = gameView.cradNumber / 2
        
        // 当前卡牌赋值
        gameView.cradNumber = number
        
        // 新的卡牌赋值
        let newView = list[index]
        newView.cradNumber = number
        
        // 添加动画
        newView.frame = gameView.frame
        newView.alpha = 0.0
        gameView.alpha = 0
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            newView.frame = newView.currentFrame ?? CGRect.zero
            newView.alpha = 1.0
            gameView.alpha = 1.0
            
        } completion: { _ in
            self.view.isUserInteractionEnabled = true
            
            // 消除卡片
            if newView.cradNumber == 2 {
                self.view.isUserInteractionEnabled = false
                UIView.animate(withDuration: 0.25) {
                    newView.alpha = 0
                    gameView.alpha = 0
                } completion: { _ in
                    self.view.isUserInteractionEnabled = true
                    newView.alpha = 1
                    gameView.alpha = 1
                    newView.cradNumber = 0
                    gameView.cradNumber = 0
                    
                    self.totalScore += 4
                    self.updateScoreUI()
                    
                    self.initRandom()
                }
            } else {
                // 生成新的卡牌后，没有多余的位置了，代表游戏结束了，否则，增加卡牌
                if list.filter({ $0.cradNumber == 0 }).count == 0 {
                    self.gameDone()
                } else {
                    self.initRandom()
                }
            }
            
        }
    }
    
    /// 在空的位置生成一个随机数
    private func initRandom() {
        
        guard let listView = self.viewMain.subviews as? [SmashingCardGameView] else { return }
        
        // 取出所有空位，并随机定位一个位置
        let list = listView.filter({ $0.cradNumber == 0 })
        
        // 如果半数格子有卡牌，调低卡牌生成概率到五分之一
        if list.count < listView.count / 2 && Int.random(in: 0...4) < 4 {
            return
        }
        
        // 没有空位了，则游戏结束
        if list.count == 0 {
            self.gameDone()
            return
        }
        let index = Int.random(in: 0...(list.count - 1))
        
        // 新的卡牌数值
        let numberIndex = Int.random(in: 0...(listNew.count - 1))
        let number = listNew[numberIndex]
        
        // 赋值
        let gameView = list[index]
        gameView.cradNumber = number
        
        self.view.isUserInteractionEnabled = false
        gameView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            gameView.alpha = 1
            
        } completion: { _ in
            self.view.isUserInteractionEnabled = true
            
            // 生成新的卡牌后，没有多余的位置了，代表游戏结束了
            if list.filter({ $0.cradNumber == 0 }).count == 0 {
                self.gameDone()
            }
        }
        
    }
    
}
