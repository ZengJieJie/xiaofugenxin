
import UIKit

/// 加减乘除算法卡牌游戏卡牌数据
class OperationCardGameData: NSObject {
    
    /// 初始化卡牌列表数据
    static func initListData() -> [Int] {
        
        var list: [Int] = []
        
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        list.append(5)
        list.append(6)
        list.append(7)
        list.append(8)
        list.append(9)
        list.append(10)
        
        return list.shuffled()
    }

}
