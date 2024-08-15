
import UIKit

/// 加减乘除算法卡牌游戏列表界面
class OperationCardGameTableView: UIView {
    
    /// 数据源
    private var listData = OperationCardGameData.initListData()
    
    /// 回调
    var block: ((Int)->())? = nil
    
    /// 数据列表
    private let tableView = UITableView(frame: CGRect(), style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        // 表格
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(OperationCardGameTableViewCell.self)
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension OperationCardGameTableView {
    
    /// 移除数字
    func removeNumber(number: Int) {
        self.listData.removeAll(where: { $0 == number })
        self.tableView .reloadData()
    }
    
    /// 添加数字
    func addNumber(number: Int) {
        self.listData.append(number)
        self.tableView .reloadData()
    }
    
    /// 随机获取两个数字
    func getTowNumber() -> (Int, Int) {
        let number1 = self.listData[Int.random(in: 0..<self.listData.count)]
        
        let newList = self.listData.filter({ $0 != number1 })
        let number2 = newList[Int.random(in: 0..<newList.count)]
        
        return (number1, number2)
    }
    
    /// 随机获取三个数字
    func getThreeNumber() -> (Int, Int, Int) {
        let number1 = self.listData[Int.random(in: 0..<self.listData.count)]
        
        let newList = self.listData.filter({ $0 != number1 })
        let number2 = newList[Int.random(in: 0..<newList.count)]
        
        let newList2 = newList.filter({ $0 != number2 })
        let number3 = newList2[Int.random(in: 0..<newList2.count)]
        
        return (number1, number2, number3)
    }
    
    /// 重置数据
    func resetData() {
        self.listData = OperationCardGameData.initListData()
        self.tableView.reloadData()
    }
    
}

extension OperationCardGameTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == self.listData.count - 1 {
            return tableView.frame.width * 264.0 / 194.0
        }
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let number = self.listData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(OperationCardGameTableViewCell.self, indexPath) as! OperationCardGameTableViewCell
        cell.setData(number: number)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let number = self.listData[indexPath.row]
        
        if let block = self.block {
            block(number)
        }
    }
}
