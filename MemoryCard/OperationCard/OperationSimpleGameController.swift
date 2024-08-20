
import UIKit

/// 加减乘除算法卡牌游戏控制器-简单
class OperationSimpleGameController: OperationBaseViewController {
    
    /// 计算结果
    private let labelResults = UILabel()
    /// 左边按钮
    private let btnLeft = UIButton()
    /// 符号
    private let labelOperation = UILabel()
    /// 左边按钮
    private let btnRight = UIButton()
    /// 卡牌列表视图
    private let viewTable = OperationCardGameTableView()
    
    /// 计算结果
    private var numberResults: Float = 0.0
    /// 计算符号 1+,2-,3×,4÷,5%
    private var numberSymbol = 0

    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .systemBackground
        
        // 背景图片
        let imgvBack = UIImageView()
        imgvBack.image = .init(named: "OperationBack")
        imgvBack.contentMode = .scaleAspectFill
        imgvBack.clipsToBounds = true
        self.view.addSubview(imgvBack)
        imgvBack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        /// 主视图
        let imgvMainBack = UIImageView()
        imgvMainBack.image = .init(named: "OperationGameBack")
        self.view.addSubview(imgvMainBack)
        imgvMainBack.safeAreaAdd(21, direction: [.leading, .top, .trailing, .bottom])
        
        // 主视图
        let viewMain = UIView()
        self.view.addSubview(viewMain)
        viewMain.snp.makeConstraints { make in
            make.left.equalTo(imgvMainBack).offset(30)
            make.top.equalTo(imgvMainBack).offset(20)
            make.width.equalTo(imgvMainBack).multipliedBy(0.65)
            make.bottom.equalTo(imgvMainBack).offset(-20)
        }
        
        labelResults.textColor = .white
        labelResults.font = .systemFont(ofSize: 20)
        labelResults.textAlignment = .center
        viewMain.addSubview(labelResults)
        labelResults.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(44)
        }
        
        labelOperation.textColor = .white
        labelOperation.font = .systemFont(ofSize: 28, weight: .bold)
        viewMain.addSubview(labelOperation)
        labelOperation.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(15)
        }
        
        //
        let imgvLeft = UIImageView()
        imgvLeft.image = .init(named: "OperationGameCardBack")
        imgvLeft.contentMode = .scaleAspectFit
        imgvLeft.clipsToBounds = true
        viewMain.addSubview(imgvLeft)
        
        btnLeft.imageView?.contentMode = .scaleAspectFit
        btnLeft.setTitleColor(.black, for: .normal)
        btnLeft.addTarget(self, action: #selector(self.btnLeftClick(sender:)), for: .touchUpInside)
        viewMain.addSubview(btnLeft)
        btnLeft.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalTo(labelOperation)
            make.width.equalToSuperview().multipliedBy(0.5).offset(-50)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        imgvLeft.snp.makeConstraints { make in
            make.edges.equalTo(btnLeft)
        }
        
        //
        let imgvRight = UIImageView()
        imgvRight.image = .init(named: "OperationGameCardBack")
        imgvRight.contentMode = .scaleAspectFit
        imgvRight.clipsToBounds = true
        viewMain.addSubview(imgvRight)
        
        btnRight.imageView?.contentMode = .scaleAspectFit
        btnRight.setTitleColor(.black, for: .normal)
        btnRight.addTarget(self, action: #selector(self.btnRightClick(sender:)), for: .touchUpInside)
        viewMain.addSubview(btnRight)
        btnRight.snp.makeConstraints { make in
            make.width.height.equalTo(btnLeft)
            make.right.equalTo(-10)
            make.centerY.equalTo(labelOperation)
        }
        imgvRight.snp.makeConstraints { make in
            make.edges.equalTo(btnRight)
        }
        
        viewTable.block = { [weak self] number in
            guard let weakSelf = self else { return }
            
            weakSelf.enterNumber(number: number)
        }
        self.view.addSubview(viewTable)
        viewTable.snp.makeConstraints { make in
            make.top.bottom.equalTo(viewMain)
            make.left.equalTo(viewMain.snp.right).offset(10)
        }
        
        // 关闭按钮
        let btnClose = UIButton()
        btnClose.setBackgroundImage(.init(named: "OperationGameClose"), for: .normal)
        btnClose.addTarget(self, action: #selector(self.btnCloseClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnClose)
        btnClose.snp.makeConstraints { make in
            make.top.equalTo(viewTable)
            make.left.equalTo(viewTable.snp.right).offset(10)
            make.right.equalTo(imgvMainBack).offset(-25)
            make.height.width.equalTo(50)
        }
        
        // 刷新按钮
        let btnRefresh = UIButton()
        btnRefresh.setBackgroundImage(.init(named: "OperationGameRefresh"), for: .normal)
        btnRefresh.addTarget(self, action: #selector(self.btnRefreshClick(sender:)), for: .touchUpInside)
        btnRefresh.uiCornerRadius(25)
        self.view.addSubview(btnRefresh)
        btnRefresh.snp.makeConstraints { make in
            make.top.equalTo(btnClose.snp.bottom).offset(20)
            make.left.equalTo(btnClose)
            make.height.width.equalTo(btnClose)
        }
        
        self.initSymbolAndResults()
        
    }

}

extension OperationSimpleGameController {
    
    /// 初始化符号和计算值
    private func initSymbolAndResults() {
        self.numberSymbol = Int.random(in: 1...5)
        
        let number = self.viewTable.getTowNumber()
        
        if self.numberSymbol == 1 {
            
            self.numberResults = Float(number.0 + number.1)
            self.labelOperation.text = "+"
            
        } else if self.numberSymbol == 2 {
            
            self.numberResults = Float(number.0 - number.1)
            self.labelOperation.text = "-"
            
        } else if self.numberSymbol == 3 {
            
            self.numberResults = Float(number.0 * number.1)
            self.labelOperation.text = "×"
            
        } else if self.numberSymbol == 4 {
            
            self.numberResults = Float(number.0) / Float(number.1)
            self.labelOperation.text = "÷"
            
        } else if self.numberSymbol == 5 {
            
            self.numberResults = Float(number.0 % number.1)
            self.labelOperation.text = "%"
            
        }
        
        if self.numberSymbol == 4 {
            self.labelResults.text = "Calculation results: " + String(format: "%.2f", self.numberResults)
            
        } else {
            self.labelResults.text = "Calculation results: \(Int(self.numberResults))"
            
        }
        
    }
    
    /// 关闭按钮点击事件
    @objc private func btnCloseClick(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /// 刷新按钮点击事件
    @objc private func btnRefreshClick(sender: UIButton) {
        
//        self.btnLeft.setTitle(nil, for: .normal)
        self.btnLeft.setImage(nil, for: .normal)
        self.btnLeft.tag = 0
        
//        self.btnRight.setTitle(nil, for: .normal)
        self.btnRight.setImage(nil, for: .normal)
        self.btnRight.tag = 0
        
        self.viewTable.resetData()
        self.initSymbolAndResults()
        
    }
    
    /// 左边按钮点击事件
    @objc private func btnLeftClick(sender: UIButton) {
        
        if sender.tag != 0 {
//            self.btnLeft.setTitle(nil, for: .normal)
            self.btnLeft.setImage(nil, for: .normal)
            
            self.viewTable.addNumber(number: sender.tag)
            
            self.btnLeft.tag = 0
        }
        
    }
    
    /// 右边按钮点击事件
    @objc private func btnRightClick(sender: UIButton) {
        
        if sender.tag != 0 {
//            self.btnRight.setTitle(nil, for: .normal)
            self.btnRight.setImage(nil, for: .normal)
            
            self.viewTable.addNumber(number: sender.tag)
            
            self.btnRight.tag = 0
        }
    }
    
    /// 选择了卡牌
    private func enterNumber(number: Int) {
        
        if self.btnLeft.tag == 0 {
            self.btnLeft.tag = number
//            self.btnLeft.setTitle("\(number)", for: .normal)
            self.btnLeft.setImage(.init(named: "OperationGameHONG_\(number)"), for: .normal)
            
            self.viewTable.removeNumber(number: number)
            
        } else if self.btnRight.tag == 0 {
            self.btnRight.tag = number
//            self.btnRight.setTitle("\(number)", for: .normal)
            self.btnRight.setImage(.init(named: "OperationGameHONG_\(number)"), for: .normal)
            
            self.viewTable.removeNumber(number: number)
            
        }
        
        // 有空值，返回
        if self.btnLeft.tag == 0 || self.btnRight.tag == 0 {
            return;
        }
        
        // 根据运算和卡牌值进行计算
        let number = (self.btnLeft.tag, self.btnRight.tag)
        var validate = false
        
        if self.numberSymbol == 1 {
            
            validate = self.numberResults == Float(number.0 + number.1)
            
        } else if self.numberSymbol == 2 {
            
            validate = self.numberResults == Float(number.0 - number.1)
            
        } else if self.numberSymbol == 3 {
            
            validate = self.numberResults == Float(number.0 * number.1)
            
        } else if self.numberSymbol == 4 {
            
            validate = self.numberResults == Float(number.0) / Float(number.1)
            
        } else if self.numberSymbol == 5 {
            
            validate = self.numberResults == Float(number.0 % number.1)
            
        }
        
        // 验证成功
        if validate {
            self.view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 1.5) {
                self.btnLeft.alpha = 0
                self.btnRight.alpha = 0
                
            } completion: { _ in
//                self.btnLeft.setTitle(nil, for: .normal)
                self.btnLeft.setImage(nil, for: .normal)
                self.btnLeft.tag = 0
                
//                self.btnRight.setTitle(nil, for: .normal)
                self.btnRight.setImage(nil, for: .normal)
                self.btnRight.tag = 0
                
                self.btnLeft.alpha = 1
                self.btnRight.alpha = 1
                
                self.viewTable.resetData()
                self.initSymbolAndResults()
                
                self.view.isUserInteractionEnabled = true
            }

        } else { // 验证失败
            
            self.shake(view: self.btnLeft)
            self.shake(view: self.btnRight)
        }
        
        
    }
    
    /// 抖一抖
    private func shake(view: UIView) {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = 4
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5.0, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5.0, y: view.center.y))
          
        view.layer.add(animation, forKey: "shake")
        
    }
    
}
