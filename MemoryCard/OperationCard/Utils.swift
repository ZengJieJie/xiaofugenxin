
import UIKit

/// 便利属性和方法
class Utils {
    
    // MARK: - 便利属性
    
    /// 屏幕宽度
    static let KWidth = {
        return UIScreen.main.bounds.size.width
    }()
    
    /// 屏幕高度
    static let KHeight = {
        return UIScreen.main.bounds.size.height
    }()
    
    /// 系统安全区域
    static let KSafeArea = {
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.safeAreaInsets ?? UIEdgeInsets()
    }()
    
    /// 获取 keyWindow
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes.filter{ $0.activationState == .foregroundActive }.compactMap { $0 as? UIWindowScene }.first?.windows.filter { $0.isKeyWindow }.first
    }
}
