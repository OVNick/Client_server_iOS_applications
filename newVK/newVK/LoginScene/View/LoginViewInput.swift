//
//  LoginViewInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation
import WebKit

/// Входящий протокол формы авторизации.
protocol LoginViewInput: AnyObject {
    /// Загрузить страницу авторизации через WebView.
    ///  - Parameter request: Запрос на авторизацию для WebView.
    func loadAuthorization(with request: URLRequest)
}
