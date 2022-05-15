//
//  FriendsViewInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол сцены "Друзья".
protocol FriendsViewInput: AnyObject {
    /// Установить друзей в таблицу.
    func setFriends(friends: [FriendItemModel])
}
