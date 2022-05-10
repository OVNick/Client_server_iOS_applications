//
//  DTO.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Патерн для передачи данных между подсистемами приложения.
enum DTO {
    struct Response<T: Decodable>:Decodable {
        let response: Items<T>
    }
    
    struct Items<T:Decodable>: Decodable {
        let items: [T]
    }

    /// Перечисление для сцены "Друзья".
    enum FriendsScene {
        struct Friend: Decodable {
            let id: Int
            let firstName: String
            let lastName: String
            let photo50: String

            enum CodingKeys: String, CodingKey {
                case id
                case firstName = "first_name"
                case lastName = "last_name"
                case photo50 = "photo_50"
            }
        }
    }
}
