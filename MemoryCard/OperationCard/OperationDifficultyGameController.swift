
import UIKit

/// 加减乘除算法卡牌游戏控制器-困难
class OperationDifficultyGameController: OperationBaseViewController {
    
    /// 计算结果
    private let labelResults = UILabel()
    /// 左边按钮
    private let btnLeft = UIButton()
    /// 符号一
    private let labelOperationLeft = UILabel()
    /// 中间按钮
    private let btnCenter = UIButton()
    /// 符号二
    private let labelOperationRight = UILabel()
    /// 左边按钮
    private let btnRight = UIButton()
    /// 卡牌列表视图
    private let viewTable = OperationCardGameTableView()
    
    /// 计算结果
    private var numberResults: Float = 0.0
    /// 计算符号一 1+,2-,3×,4÷,5%
    private var numberSymbolLeft = 0
    /// 计算符号二 1+,2-,3×,4÷,5%
    private var numberSymbolRight = 0
    
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
        viewMain.addSubview(labelResults)
        labelResults.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        //
        let imgvLeft = UIImageView()
        imgvLeft.image = .init(named: "OperationGameCardBack")
        imgvLeft.contentMode = .scaleAspectFit
        imgvLeft.clipsToBounds = true
        viewMain.addSubview(imgvLeft)
        
        btnLeft.setTitleColor(.black, for: .normal)
        btnLeft.addTarget(self, action: #selector(self.btnLeftClick(sender:)), for: .touchUpInside)
        viewMain.addSubview(btnLeft)
        btnLeft.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.333).offset(-30)
            make.height.equalTo(btnLeft.snp.width).multipliedBy(448.0 / 329.0) // 329 × 448
        }
        imgvLeft.snp.makeConstraints { make in
            make.edges.equalTo(btnLeft)
        }
        
        labelOperationLeft.textColor = .white
        labelOperationLeft.font = .systemFont(ofSize: 28, weight: .bold)
        labelOperationLeft.textAlignment = .center
        viewMain.addSubview(labelOperationLeft)
        labelOperationLeft.snp.makeConstraints { make in
            make.left.equalTo(btnLeft.snp.right)
            make.centerY.equalToSuperview()
        }
        
        //
        let imgvCenter = UIImageView()
        imgvCenter.image = .init(named: "OperationGameCardBack")
        imgvCenter.contentMode = .scaleAspectFit
        imgvCenter.clipsToBounds = true
        viewMain.addSubview(imgvCenter)
        
        btnCenter.setTitleColor(.black, for: .normal)
        btnCenter.addTarget(self, action: #selector(self.btnCenterClick(sender:)), for: .touchUpInside)
        viewMain.addSubview(btnCenter)
        btnCenter.snp.makeConstraints { make in
            make.left.equalTo(labelOperationLeft.snp.right)
            make.width.height.equalTo(btnLeft)
            make.centerY.equalToSuperview()
        }
        imgvCenter.snp.makeConstraints { make in
            make.edges.equalTo(btnCenter)
        }
        
        labelOperationRight.textColor = .white
        labelOperationRight.font = .systemFont(ofSize: 28, weight: .bold)
        labelOperationRight.textAlignment = .center
        viewMain.addSubview(labelOperationRight)
        labelOperationRight.snp.makeConstraints { make in
            make.left.equalTo(btnCenter.snp.right)
            make.centerY.equalToSuperview()
            make.width.equalTo(labelOperationLeft)
        }
        
        //
        let imgvRight = UIImageView()
        imgvRight.image = .init(named: "OperationGameCardBack")
        imgvRight.contentMode = .scaleAspectFit
        imgvRight.clipsToBounds = true
        viewMain.addSubview(imgvRight)
        
        btnRight.setTitleColor(.black, for: .normal)
        btnRight.addTarget(self, action: #selector(self.btnRightClick(sender:)), for: .touchUpInside)
        viewMain.addSubview(btnRight)
        btnRight.snp.makeConstraints { make in
            make.left.equalTo(labelOperationRight.snp.right)
            make.width.height.equalTo(btnLeft)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
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


extension OperationDifficultyGameController {
    
    /// 两个数字根据符号进行计算
    private func numericalCalculation(symbol: Int, number1: Float, number2: Int) -> Float {
        
        if symbol == 1 {
            
            return number1 + Float(number2)
            
        } else if symbol == 2 {
            
            return number1 - Float(number2)
            
        } else if symbol == 3 {
            
            return number1 * Float(number2)
            
        } else if symbol == 4 {
            
            return number1 / Float(number2)
            
        } else if symbol == 5 {
            
            return Float(Int(number1) % number2)
            
        }
        
        return 0.0
    }
    
    /// 初始化符号和计算值
    private func initSymbolAndResults() {
        self.numberSymbolLeft = Int.random(in: 1...5)
        
        // 如果第一个为÷，则第二个符号不能为%，因为第一个符号计算完毕后可能是小数，则不能进行%
        if self.numberSymbolLeft == 4 {
            self.numberSymbolRight = Int.random(in: 1...4)
        } else {
            self.numberSymbolRight = Int.random(in: 1...5)
        }
        
        let number = self.viewTable.getThreeNumber()
        let symbol = ["+", "-", "x", "÷", "%"]
        
        self.labelOperationLeft.text = symbol[self.numberSymbolLeft - 1]
        self.labelOperationRight.text = symbol[self.numberSymbolRight - 1]
        
        let result = self.numericalCalculation(symbol: self.numberSymbolLeft, number1: Float(number.0), number2: number.1)
        self.numberResults = self.numericalCalculation(symbol: self.numberSymbolRight, number1: result, number2: number.2)
        
        if self.numberSymbolLeft == 4 || self.numberSymbolRight == 4 {
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
        self.btnLeft.setBackgroundImage(nil, for: .normal)
        self.btnLeft.tag = 0
        
//        self.btnCenter.setTitle(nil, for: .normal)
        self.btnCenter.setBackgroundImage(nil, for: .normal)
        self.btnCenter.tag = 0
        
//        self.btnRight.setTitle(nil, for: .normal)
        self.btnRight.setBackgroundImage(nil, for: .normal)
        self.btnRight.tag = 0
        
        self.viewTable.resetData()
        self.initSymbolAndResults()
        
    }
    
    /// 左边按钮点击事件
    @objc private func btnLeftClick(sender: UIButton) {
        
        if sender.tag != 0 {
//            self.btnLeft.setTitle(nil, for: .normal)
            self.btnLeft.setBackgroundImage(nil, for: .normal)
            
            self.viewTable.addNumber(number: sender.tag)
            
            self.btnLeft.tag = 0
        }
        
    }
    
    /// 中间按钮点击事件
    @objc private func btnCenterClick(sender: UIButton) {
        
        if sender.tag != 0 {
//            self.btnCenter.setTitle(nil, for: .normal)
            self.btnCenter.setBackgroundImage(nil, for: .normal)
            
            self.viewTable.addNumber(number: sender.tag)
            
            self.btnCenter.tag = 0
        }
        
    }
    
    /// 右边按钮点击事件
    @objc private func btnRightClick(sender: UIButton) {
        
        if sender.tag != 0 {
//            self.btnRight.setTitle(nil, for: .normal)
            self.btnRight.setBackgroundImage(nil, for: .normal)
            
            self.viewTable.addNumber(number: sender.tag)
            
            self.btnRight.tag = 0
        }
    }
    
    /// 选择了卡牌
    private func enterNumber(number: Int) {
        
        if self.btnLeft.tag == 0 {
            self.btnLeft.tag = number
//            self.btnLeft.setTitle("\(number)", for: .normal)
            self.btnLeft.setBackgroundImage(.init(named: "OperationGameHONG_\(number)"), for: .normal)
            
            self.viewTable.removeNumber(number: number)
            
        } else if self.btnCenter.tag == 0 {
            self.btnCenter.tag = number
//            self.btnCenter.setTitle("\(number)", for: .normal)
            self.btnCenter.setBackgroundImage(.init(named: "OperationGameHONG_\(number)"), for: .normal)
            
            self.viewTable.removeNumber(number: number)
            
        } else if self.btnRight.tag == 0 {
            self.btnRight.tag = number
//            self.btnRight.setTitle("\(number)", for: .normal)
            self.btnRight.setBackgroundImage(.init(named: "OperationGameHONG_\(number)"), for: .normal)
            
            self.viewTable.removeNumber(number: number)
            
        }
        
        // 有空值，返回
        if self.btnLeft.tag == 0 || self.btnCenter.tag == 0 || self.btnRight.tag == 0 {
            return;
        }
        
        // 根据运算和卡牌值进行计算
        let number = (self.btnLeft.tag, self.btnCenter.tag, self.btnRight.tag)
        
        var result = self.numericalCalculation(symbol: self.numberSymbolLeft, number1: Float(number.0), number2: number.1)
        result = self.numericalCalculation(symbol: self.numberSymbolRight, number1: result, number2: number.2)
        
        // 验证成功
        if result == self.numberResults {
            
            self.view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 1.5) {
                self.btnLeft.alpha = 0
                self.btnCenter.alpha = 0
                self.btnRight.alpha = 0
                
            } completion: { _ in
//                self.btnLeft.setTitle(nil, for: .normal)
                self.btnLeft.setBackgroundImage(nil, for: .normal)
                self.btnLeft.tag = 0
                
//                self.btnCenter.setTitle(nil, for: .normal)
                self.btnCenter.setBackgroundImage(nil, for: .normal)
                self.btnCenter.tag = 0
                
//                self.btnRight.setTitle(nil, for: .normal)
                self.btnRight.setBackgroundImage(nil, for: .normal)
                self.btnRight.tag = 0
                
                self.btnLeft.alpha = 1
                self.btnCenter.alpha = 1
                self.btnRight.alpha = 1
                
                self.viewTable.resetData()
                self.initSymbolAndResults()
                
                self.view.isUserInteractionEnabled = true
            }

        } else { // 验证失败
            
            self.shake(view: self.btnLeft)
            self.shake(view: self.btnCenter)
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
