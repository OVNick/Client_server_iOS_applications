//
//  GroupModel.swift
//  newVK
//
//  Created by Николай Онучин on 16.05.2022.
//

import Foundation
import RealmSwift

struct GroupResponce: Decodable {
    let response: GroupItems
}

struct GroupItems: Decodable {
    let items: [GroupModel]
}

/// Модель группы.
class GroupModel: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photo50 = ""

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo50 = "photo_50"
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}
