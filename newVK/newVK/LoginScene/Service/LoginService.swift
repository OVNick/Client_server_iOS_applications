//
//  LoginService.swift
//  newVK
//
//  Created by Николай Онучин on 25.04.2022.
//

import Foundation

/// Cервис авторизации пользователя.
final class LoginService: LoginServiceInput {
    
    func generateAuthorizationRequest() -> URLRequest {
        /// Конструктор URL.
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8136636"),
            URLQueryItem(name: "scope", value: "friends, wall, groups, photos"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))

        return request
    }
}
