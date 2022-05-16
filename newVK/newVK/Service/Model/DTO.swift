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
