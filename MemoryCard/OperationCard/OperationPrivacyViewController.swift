//
//  OperationPrivacyViewController.swift
//  MemoryCard
//
//  Created by jin fu on 2024/8/15.
//

import UIKit
import WebKit
import SnapKit

class OperationPrivacyViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    var bg: UIImageView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    var url: String?
    
    var btnClose: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubViews()

        activityIndicator.startAnimating()
        
        if let url = url {
            btnClose.isHidden = true
            if let urlR = URL(string: url) {
                let request = URLRequest(url: urlR)
                webView.load(request)
            }
        } else {
            if let urlR = URL(string: "https://tinyurl.com/PattiAlgorithm") {
                let request = URLRequest(url: urlR)
                webView.load(request)
            }
        }
    }
    
    private func initSubViews() {
        bg = UIImageView.init(image: UIImage.init(named: "OperationBack"))
        bg.contentMode = .scaleAspectFill
        view.addSubview(bg)
        bg.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        webView = WKWebView(frame: self.view.frame)
        webView.isHidden = true
        webView.navigationDelegate = self
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
        
        btnClose = UIButton(type: .custom)
        btnClose.setBackgroundImage(.init(named: "OperationGameClose"), for: .normal)
        btnClose.addTarget(self, action:#selector(btnCloseClick), for: .touchUpInside)
        self.view.addSubview(btnClose)
        btnClose.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.leading.equalTo(30)
            make.height.width.equalTo(50)
        }
    }
    
    @objc private func btnCloseClick() {
        dismiss(animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.bg.isHidden = true
            self.webView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.bg.isHidden = true
            self.webView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
}
