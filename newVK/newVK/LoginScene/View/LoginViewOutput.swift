//
//  LoginViewOutput.swift
//  newVK
//
//  Created by Николай Онучин on 04.05.2022.
//

import WebKit

/// Исходящий протокол формы авторизации.
protocol LoginViewOutput {
    /// Собрать WebView.
    func makeWebView(_ webView: WKWebView,
                     decidePolicyFor navigationResponse: WKNavigationResponse,
                     decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void)
    
    /// Загрузить сцену авторизации.
    func loadAuthorizationScene()
}
