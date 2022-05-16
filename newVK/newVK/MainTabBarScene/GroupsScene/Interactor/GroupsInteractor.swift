//
//  GroupsInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Интерактор сцены "Группы".
final class GroupsInteractor {
    
    /// Свойство, отвечающее за сервисный слой сцены "Группы".
    private let service: GroupsServiceInput

    /// Инициализатор сервиного слоя сцены "Группы".
    init(service: GroupsServiceInput = GroupsService()) {
        self.service = service
    }
}


// MARK: - GroupsInteractorInput

extension GroupsInteractor: GroupsInteractorInput {
    // Загружаем группы.
    func loadGroups(completion: @escaping ([GroupModel]) -> Void) {
        service.loadGroups { result in
            switch result {
            case .success(let groups):
                completion(groups)
            case .failure(_):
                return
            }
        }
    }
}
