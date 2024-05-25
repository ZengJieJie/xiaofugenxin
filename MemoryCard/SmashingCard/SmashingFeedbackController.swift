
import UIKit

class SmashingFeedbackController: UIViewController {
    
    /// 文本框
    private let viewText = UITextView()

    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .systemBackground
        
        // 背景图片
        let imgvBack = UIImageView()
        imgvBack.image = .init(named: "SmashingBack")
        imgvBack.contentMode = .scaleAspectFill
        imgvBack.clipsToBounds = true
        self.view.addSubview(imgvBack)
        imgvBack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewText.uiBorder()
        viewText.uiCornerRadius(8)
        self.view.addSubview(viewText)
        viewText.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.center.equalToSuperview()
        }
        
        //
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Feedback:"
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(viewText)
            make.bottom.equalTo(viewText.snp.top).offset(-10)
        }
        
        // 提交按钮
        let btnCommit = UIButton()
        btnCommit.setTitleColor(.white, for: .normal)
        btnCommit.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btnCommit.setTitle("Submit", for: .normal)
        btnCommit.addTarget(self, action: #selector(self.btnCommitClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnCommit)
        btnCommit.safeAreaAdd(21, direction: [.bottom, .trailing])
        btnCommit.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        // 关闭按钮
        let btnClose = UIButton()
        btnClose.setBackgroundImage(.init(named: "SmashingClose"), for: .normal)
        btnClose.addTarget(self, action: #selector(self.btnCloseClick(sender:)), for: .touchUpInside)
        self.view.addSubview(btnClose)
        btnClose.safeAreaAdd(21, direction: [.top, .trailing])
        btnClose.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// 关闭按钮点击事件
    @objc private func btnCloseClick(sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    /// 关闭按钮点击事件
    @objc private func btnCommitClick(sender: UIButton) {
        guard let text = self.viewText.text, !text.isEmpty else { return }
        
        // 提交数据
        let urlString = "http://jsonplaceholder.typicode.com/posts"
        let parameters: [String: Any] = ["userId": "1", "title": text, "body" : text]
          
        sendPostRequest(with: urlString, parameters: parameters) { (data, response, error) in
            
        }
        
        self.submitDone()
    }
    
    /// 提交数据
    private func sendPostRequest(with urlString: String, parameters: [String: Any], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = self.percentEncoded(parameters: parameters)?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
          
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    /// 辅助函数，将字典转换为 x-www-form-urlencoded 格式的字符串
    private func percentEncoded(parameters: [String: Any]) -> String? {
        return parameters.map { key, value in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "\(escapedKey)=\(escapedValue)"
        }.joined(separator: "&")
    }
    
    /// 提交完成
    private func submitDone() {
        
        let alertVC = UIAlertController(title: "Feedback", message: "Thank you for your feedback", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "You are welcome.", style: .default) { [weak self] _ in
            guard let weakSelf = self else { return }
            
            weakSelf.dismiss(animated: true)
        }
        alertVC.addAction(action)
        
        self.present(alertVC, animated: true)
    }

}
