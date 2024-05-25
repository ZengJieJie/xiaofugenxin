
import UIKit

// 2048卡牌游戏卡牌视图
class SmashingCardGameView: UIControl {
    
    /// 卡片数字
    var cradNumber = 0 {
        didSet {
            self.updateUI()
        }
    }
    /// 初始位置
    var currentFrame: CGRect? = nil
    
    /// 预览图
    private let imgvCover = UIImageView()
    /// 卡牌数字
    private let labelNumber = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        
        imgvCover.contentMode = .scaleAspectFit
        imgvCover.clipsToBounds = true
        self.addSubview(imgvCover)
        self.imgvCover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        labelNumber.textColor = .white
        labelNumber.font = .systemFont(ofSize: 12, weight: .bold)
        labelNumber.textAlignment = .center
        self.addSubview(labelNumber)
        labelNumber.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 更新数据源
    private func updateUI() {
        if self.cradNumber == 0 {
            self.imgvCover.image = nil
            
        } else if self.cradNumber <= 16 {
            self.imgvCover.image = .init(named: "SmashingCrad1")
            
        } else if self.cradNumber <= 64 {
            self.imgvCover.image = .init(named: "SmashingCrad2")
            
        } else if self.cradNumber <= 512 {
            self.imgvCover.image = .init(named: "SmashingCrad3")
            
        } else {
            self.imgvCover.image = .init(named: "SmashingCrad4")
            
        }
        
        self.labelNumber.text = self.cradNumber == 0 ? "" : "\(self.cradNumber)"
    }
    
}
