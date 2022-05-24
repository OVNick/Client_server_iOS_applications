//
//  GroupsInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол интерактора  сцены "Группы".
protocol GroupsInteractorInput {
    
    /// Загрузить данные групп.
    func loadGroupsData(completion: @escaping ([GroupModel]) -> Void)
    
    /// Обновить данные групп.
    func updateGroupsData(completion: @escaping (Bool) -> Void)
}
