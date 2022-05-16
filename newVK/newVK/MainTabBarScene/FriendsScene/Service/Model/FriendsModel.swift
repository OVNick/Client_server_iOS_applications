//
//  FriendsModel.swift
//  newVK
//
//  Created by Николай Онучин on 16.05.2022.
//

import Foundation
import RealmSwift

struct FriendsResponce: Decodable {
    let response: FriendsItems
}

struct FriendsItems: Decodable {
    let items: [FriendModel]
}

/// Модель друга.
class FriendModel: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo50 = ""

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}
