//
//  GroupsInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол интерактора  сцены "Группы".
protocol GroupsInteractorInput {
    /// Загрузить группы.
    func loadGroups(completion: @escaping ([GroupModel]) -> Void)
}
