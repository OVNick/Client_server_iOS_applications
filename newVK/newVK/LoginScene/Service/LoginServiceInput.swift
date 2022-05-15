//
//  LoginServiceInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол сервиса авторизации пользователя.
protocol LoginServiceInput {
    /// Сгенерировать запрос на авторизацию пользователя.
    /// - Returns: Запрос на авторизацию.
    func generateAuthorizationRequest() -> URLRequest
}
