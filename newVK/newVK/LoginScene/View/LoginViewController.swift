//
//  LoginViewController.swift
//  newVK
//
//  Created by Николай Онучин on 20.04.2022.
//

import UIKit
import WebKit

/// Контроллер формы авторизации.
final class LoginViewController: UIViewController {
    
    ///  Свойство, обрабатывающее исходящие события.
    var output: LoginViewOutput?

    
    // MARK: - SubView
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        return view
    }()
    
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        output?.loadAuthorizationScene()
    }
}


// MARK: - LoginViewInput

extension LoginViewController: LoginViewInput {
    func loadAuthorization(with request: URLRequest) {
        // Загружаем на WebView страницу авторизации.
        webView.load(request)
    }
}


// MARK: - WKNavigationDelegate

extension LoginViewController: WKNavigationDelegate {
    /// Конфигурируем WebView.
    func configureWebView() {
        navigationController?.navigationBar.isHidden = true
        webView.navigationDelegate = self
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        output?.makeWebView(webView,
                            decidePolicyFor: navigationResponse,
                            decisionHandler: decisionHandler)
    }
}

