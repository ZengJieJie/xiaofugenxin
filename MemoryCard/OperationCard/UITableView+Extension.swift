
import UIKit

extension UITableView {
    
    /// 注册cell
    func register(_ cls: AnyClass) {
        self.register(cls, forCellReuseIdentifier: NSStringFromClass(cls))
    }
    
    /// 获取cell
    func dequeueReusableCell(_ cls: AnyClass, _ indexPath: IndexPath) -> UITableViewCell {
        self.dequeueReusableCell(withIdentifier: NSStringFromClass(cls), for: indexPath)
    }
}
