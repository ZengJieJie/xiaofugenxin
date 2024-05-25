import UIKit

extension UIView {
    
    // MARK: - 便捷属性
    
    /// width
    var width : CGFloat {
        return frame.size.width
    }
    
    /// height
    var height : CGFloat {
        return frame.size.height
    }
    
    /// x
    var x : CGFloat {
        return frame.origin.x
    }
    
    /// y
    var y : CGFloat {
        return frame.origin.y
    }
    
    /// size
    var size : CGSize {
        return bounds.size
    }
    
    
    // MARK: - 拓展方法
    
    
    /// 如果安全区域大于零，则边距为零，否则补足size
    /// 需要在添加到父视图后再调用
    /// - Parameters:
    ///   - size: 补足值（right和bottom会自动取负值）
    ///   - direction: 补足方向
    func safeAreaAdd(_ size: CGFloat, direction: NSDirectionalRectEdge = [.leading, .top, .trailing, .bottom]) {
        
        self.snp.makeConstraints { make in
            
            if direction.contains(.leading) {
                make.left.equalTo(size > Mts.KSafeArea.left ? size : Mts.KSafeArea.left)
            }
            if direction.contains(.top) {
                make.top.equalTo(size > Mts.KSafeArea.top ? size : Mts.KSafeArea.top)
            }
            if direction.contains(.trailing) {
                make.right.equalTo(Mts.KSafeArea.right > size ? -Mts.KSafeArea.right : -size)
            }
            if direction.contains(.bottom) {
                make.bottom.equalTo(Mts.KSafeArea.bottom > size ? -Mts.KSafeArea.bottom : -size)
            }
            
        }
        
    }
    
    /// 快捷添加一个弹框视图
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 提示信息
    ///   - actionTitle: 按钮标题
    ///   - action: 按钮事件
    func showAlertView(title: String, message: String, actionTitle: String = "", action: (() ->())? = nil) {
        
        let view = SmashingCardAlertView(title: title, message: message, actionTitle: actionTitle, action: action)
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    /// 设置圆角
    /// - Parameter corner: 圆角大小
    func uiCornerRadius(_ corner : CGFloat = 4.0) {
        layer.cornerRadius = corner
        layer.masksToBounds = true
    }
    
    /// 给view添加边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    func uiBorder(width: CGFloat = 1.0, color: UIColor = .label){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    /// 获取当前view的root控制器
    /// - Returns: root控制器
    func viewController() -> UIViewController? {
        var responder = self as UIResponder?
        while responder != nil {
            responder = responder?.next
            
            if responder is UIViewController {
                return responder as? UIViewController
            }
        }
        return nil
    }
    
    /// 子视图进行线性布局，请在全部子视图添加后调用
    /// - Parameters:
    ///   - gap: 子视图的间隔
    ///   - start: 线性开始间隔
    ///   - end: 线性结束间隔
    ///   - isV: 是否为纵向，默认为横向
    func uiLineLayout(gap: CGFloat = 0.0, start: CGFloat = 0.0, end: CGFloat = 0.0, isV: Bool = false) {
        let list = self.subviews
        var viewMark: UIView?
        
        for view in list {
            if (isV) { // 纵向
                view.snp.makeConstraints { make in
                    if let viewMark = viewMark {
                        make.top.equalTo(viewMark.snp.bottom).offset(gap)
                    } else {
                        make.top.equalTo(start)
                    }
                    
                    if view == list.last {
                        make.bottom.equalTo(end).priority(.low)
                    }
                }
            }else {// 横向
                view.snp.makeConstraints { make in
                    if let viewMark = viewMark {
                        make.left.equalTo(viewMark.snp.right).offset(gap)
                    } else {
                        make.left.equalTo(start)
                    }
                    
                    if view == list.last {
                        make.right.equalTo(end).priority(.low)
                    }
                }
            }
            viewMark = view
        }
    }
}
