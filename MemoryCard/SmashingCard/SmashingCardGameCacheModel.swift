
import UIKit

/// 文件缓存路径
fileprivate let cacheFilePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last ?? "") + "/gamefile.json"

// 2048卡牌游戏数据缓存模型
class SmashingCardGameCacheModel: Codable {
    
    /// 点击次数
    var clickCount = 0
    /// 总分
    var totalScore = 0
    /// 游戏时间
    var time = ""
    
    init(clickCount: Int = 0, totalScore: Int = 0) {
        // 获取当前日期和时间
        let currentDate = Date()
        
        // 创建日期格式化器
        let dateFormatter = DateFormatter()
        
        // 设置日期格式化器的时区为我们提供的时区
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        
        // 设置日期格式化器的日期和时间格式
        // 这里使用 ISO 8601 格式作为示例
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        // 使用日期格式化器格式化当前日期和时间
        let timeString = dateFormatter.string(from: currentDate)
        
        self.clickCount = clickCount
        self.totalScore = totalScore
        self.time = timeString
    }
    
    /// 缓存数据
    func cacheData() {
        var list = SmashingCardGameCacheModel.loadSmashingCardGameCacheListFromJSONFile() ?? []
        list.insert(self, at: 0)
        
        if list.count > 100 {
            list.removeLast()
        }
        
        do {
            // 将模型数组编码为 JSON 数据
            let jsonData = try JSONEncoder().encode(list)
            
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("gamefile.json")
            
            // 将 JSON 字符串写入文件
            try jsonData.write(to: fileURL)
        } catch {
            // 处理错误
            print("Error saving persons to JSON file: \(error)")
        }
    }
    
    /// 读取缓存数据
    static func loadSmashingCardGameCacheListFromJSONFile() -> [SmashingCardGameCacheModel]? {
        do {
            // 获取文件的 URL
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("gamefile.json")
              
            // 读取文件内容到 Data 对象
            let data = try Data(contentsOf: fileURL)
              
            // 使用 JSONDecoder 解码 Data 对象为 Person 数组
            let decoder = JSONDecoder()
            let persons = try decoder.decode([SmashingCardGameCacheModel].self, from: data)
              
            return persons
        } catch {
            // 处理错误
            print("Error loading persons from JSON file: \(error)")
            return nil
        }
    }
}
