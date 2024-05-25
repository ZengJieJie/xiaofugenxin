
import UIKit

/// 便利属性和方法
@objcMembers class Mts: NSObject {
    
    // MARK: - 便利属性
    
    /// 屏幕宽度
    static let SW = {
        return UIScreen.main.bounds.size.width
    }()
    
    /// 屏幕高度
    static let SH = {
        return UIScreen.main.bounds.size.height
    }()
    
    /// 系统安全区域
    static let KSafeArea = {
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.safeAreaInsets ?? UIEdgeInsets()
    }()
}
