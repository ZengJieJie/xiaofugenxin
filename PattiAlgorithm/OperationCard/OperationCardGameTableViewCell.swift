
import UIKit

/// 加减乘除算法卡牌游戏列表界面cell
class OperationCardGameTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 卡牌数值
    private let labelNumber = UILabel()
    /// 卡牌图片
    private let imgvCard = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.clipsToBounds = true
        
        imgvCard.contentMode = .scaleAspectFill
        imgvCard.clipsToBounds = true
        self.contentView.addSubview(imgvCard)
        imgvCard.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(imgvCard.snp.width).multipliedBy(264.0 / 194.0) // 194 × 264
        }
        
//        labelNumber.textColor = .label
//        labelNumber.font = .systemFont(ofSize: 20, weight: .semibold)
//        labelNumber.textAlignment = .center
//        self.contentView.addSubview(labelNumber)
//        labelNumber.snp.makeConstraints { make in
//            make.left.right.equalTo(0)
//            make.top.equalTo(30)
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置数据
    func setData(number: Int) {
        self.imgvCard.image = .init(named: "OperationGameHONG_\(number)")
//        self.labelNumber.text = "\(number)"
        
    }
    
}
