//
//  FriendsInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол интерактора  сцены "Друзья".
protocol FriendsInteractorInput {
    /// Загрузить друзей.
    func loadFriends(completion: @escaping ([FriendModel]) -> Void)
    /// Загрузить id выбранного друга в DataManager.
    func loadId(userId: Int)
}
