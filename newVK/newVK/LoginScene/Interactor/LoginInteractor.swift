//
//  LoginInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 04.05.2022.
//

import Foundation
import WebKit

/// Интерактор для формы авторизации через WebView.
final class LoginInteractor {
    
    /// Свойство, отвечающее за сервис авторизации.
    private let service: LoginServiceInput

    /// Инициализатор.
    /// - Parameter service: Свойство, отвечающее за сервис авторизации.
    init(service: LoginServiceInput = LoginService()) {
        self.service = service
    }
}


// MARK: - LoginInteractorInput
extension LoginInteractor: LoginInteractorInput {

    // Создаем запрос на авторизацию.
    func makeRequestAuthorizationScene() -> URLRequest {
        service.generateAuthorizationRequest()
    }

    // Отслеживаем и обрабатываем ответ сервера при переходе.
    func makeRequestWebView(_ webView: WKWebView,
                            decidePolicyFor navigationResponse: WKNavigationResponse,
                            decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void,
                            isValidKeys: @escaping (Bool) -> Void) {
        
        // Проверяем URL, на который совершено перенаправление.
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        // Формируем словарь с параметрами из строки.
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        // Сохраняем данные о текущем пользователе в синглтон Session.
        if let token = params["access_token"],
           let userId = params["user_id"],
           let id = Int(userId) {
            Session.instance.userId = id
            Session.instance.token = token
            print("token: \(token)")
            isValidKeys(true)
        } else {
            isValidKeys(false)
        }
        decisionHandler(.cancel)
    }
}
