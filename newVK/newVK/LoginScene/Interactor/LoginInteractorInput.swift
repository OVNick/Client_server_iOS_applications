//
//  LoginInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation
import WebKit

/// Входящий протокол интерактора формы авторизации.
protocol LoginInteractorInput {
    /// Создать запрос на авторизацию.
    ///  - Returns: Запрос на авторизацию.
    func makeRequestAuthorizationScene() -> URLRequest

    /// Отследить и обработать ответ сервера при переходе.
    func makeRequestWebView(_ webView: WKWebView,
                            decidePolicyFor navigationResponse: WKNavigationResponse,
                            decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void,
                            isValidKeys: @escaping (Bool) -> Void)
}
