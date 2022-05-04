//
//  LoginPresenter.swift
//  newVK
//
//  Created by Николай Онучин on 04.05.2022.
//

import WebKit

/// Презентер для формы авторизации.
final class LoginPresenter {

    /// Свойство, отвечающее за представление формы авторизации.
    weak var view: LoginViewInput?
    /// Свойство, отвечающее за роутер формы авторизации.
    private let router: LoginRouterInput
    /// Свойство, отвечающее за интерактор формы авторизации.
    private let interactor: LoginInteractorInput

    /// Инициализатор.
    /// - Parameters:
    ///   - router: Свойство, отвечающее за роутер формы авторизации.
    ///   - interactor: Свойство, отвечающее за интерактор формы авторизации.
    init(router: LoginRouterInput,
         interactor: LoginInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}


// MARK: - LoginViewOutput
extension LoginPresenter: LoginViewOutput {
    // Загружаем сцену авторизации.
    func loadAuthorizationScene() {
        /// Запрос на авторизацию.
        let request = interactor.makeRequestAuthorizationScene()
        // Загружаем страницу авторизации через WebView.
        view?.loadAuthorization(with: request)
    }

    func makeWebView(_ webView: WKWebView,
                     decidePolicyFor navigationResponse: WKNavigationResponse,
                     decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        interactor.makeRequestWebView(webView,
                                      decidePolicyFor: navigationResponse,
                                      decisionHandler: decisionHandler) { [weak self] isValid in
            guard let self = self else { return }
            if isValid {
                self.router.openMainScene()
            } else {
                return
            }
        }
    }
}
