//
//  Constants.swift
//  newVK
//
//  Created by Николай Онучин on 25.04.2022.
//

import Foundation

/// Cтруктура, хранящая константы.
struct Constants {
    enum Service: String, CaseIterable {
        /// Методы запроса.
        enum TypeMethods: String, CaseIterable {
            /// Запрос информации о друзьях пользователя.
            case friendsGet = "/method/friends.get"
        }
        case scheme = "https"
        case host = "api.vk.com"
        case get = "GET"
        case post = "POST"
    }
}
