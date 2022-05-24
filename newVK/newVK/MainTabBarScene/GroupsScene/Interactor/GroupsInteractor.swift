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
    
    // Загружаем данные групп.
    func loadGroupsData(completion: @escaping ([GroupModel]) -> Void) {
        
        service.loadData { data in
            completion(data)
        }
    }
    
    // Обновляем данные групп.
    func updateGroupsData(completion: @escaping (Bool) -> Void) {
        service.updateData { updateFlag in
            completion(updateFlag)
        }
    }
}
