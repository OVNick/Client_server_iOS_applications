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
    
    // Загружаем данные друзей.
    func loadFriendsData(completion: @escaping ([FriendModel]) -> Void) {
        
        service.loadData { data in
            completion(data)
        }
    }
    
    // Обновляем данные друзей.
    func updateFriendsData(completion: @escaping (Bool) -> Void) {
        service.updateData { updateFlag in
            completion(updateFlag)
        }
    }
}
