//
//  GroupsServiceInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол сервиса сцены "Группы".
protocol GroupsServiceInput {
    /// Загрузить группы текущего пользователя.
    func loadGroups(completion: @escaping ((Result<[DTO.GroupsScene.Group], GroupsServiceError>) -> ()))
}
