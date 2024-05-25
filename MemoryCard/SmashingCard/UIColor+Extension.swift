import UIKit

extension UIColor {
    
    // MARK: - UI标准色
    
    /// 分割线颜色
    static let colorLine: UIColor = UIColor(named: "Line")!
    /// 遮罩颜色
    static let colorMask: UIColor = UIColor(named: "Mask")!
    /// 背景颜色
    static let colorBack: UIColor = UIColor(named: "Back")!
    /// 背景颜色
    static let colorCard: UIColor = UIColor(named: "Card")!
    
    /// 根据16进制初始化颜色
    static func hex(_ hex: String, alpha: CGFloat = 1) -> UIColor {
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = alpha
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("====Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
            }
        } else {
            print("====Scan hex error")
        }
        return self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
