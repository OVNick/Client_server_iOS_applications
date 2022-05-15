//
//  FriendsInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Интерактор сцены "Друзья".
final class FriendsInteractor {
    
    /// Свойство, отвечающее за сервисный слой сцены "Друзья".
    private let service: FriendsServiceInput
    
    /// Инициализатор сервиного слоя сцены "Друзья".
    init(service: FriendsServiceInput = FriendsService()) {
        self.service = service
    }
}


// MARK: - FriendsInteractorInput

extension FriendsInteractor: FriendsInteractorInput {
    
    // Загружаем id выбранного друга в DataManager.
    func loadId(userId: Int) {
        DataManager.id = userId
    }
    
    // Загружаем друзей.
    func loadFriends(completion: @escaping ([DTO.FriendsScene.Friend]) -> Void) {
        service.loadFriends { result in
            switch result {
            case .success(let friends):
                completion(friends)
            case .failure(_):
                return
            }
        }
    }
}
