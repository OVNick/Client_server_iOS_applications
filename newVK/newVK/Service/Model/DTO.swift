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
                case id = "id"
                case firstName = "first_name"
                case lastName = "last_name"
                case photo50 = "photo_50"
            }
        }
    }
    
    /// Перечисление для сцены "Группы".
    enum GroupsScene {
        struct Group: Decodable {
            let id: Int
            let name: String
            let photo50: String

            enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
                case photo50 = "photo_50"
            }
        }
    }
    
    /// Перечисление для сцены ""Фото.
    enum PhotoScene {
        struct Photo: Decodable {
            let sizes: [Size]
            
            enum SizeCodingKeys: String, CodingKey {
                case sizes = "sizes"
            }
        }
        
        struct Size: Decodable {
            let url: String
            
            enum CodinKeys: String, CodingKey {
                case url = "url"
            }
        }
    }
}
