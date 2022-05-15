//
//  FriendsServiceInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол сервиса сцены "Друзья".
protocol FriendsServiceInput {
    /// Загрузить друзей текущего пользователя.
    func loadFriends(completion: @escaping ((Result<[DTO.FriendsScene.Friend], FriendsServiceError>) -> ()))
}
