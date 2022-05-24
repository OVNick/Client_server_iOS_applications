//
//  FriendsInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол интерактора  сцены "Друзья".
protocol FriendsInteractorInput {

    /// Загрузить id выбранного друга в DataManager.
    func loadId(userId: Int)
    
    /// Загрузить данные друзей.
    func loadFriendsData(completion: @escaping ([FriendModel]) -> Void)
    
    /// Обновить данные друзей.
    func updateFriendsData(completion: @escaping (Bool) -> Void)
}
