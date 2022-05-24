//
//  GroupsServiceInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол сервиса сцены "Группы".
protocol GroupsServiceInput {
    
    /// Обновить данные.
    func updateData(completion: @escaping (Bool) -> Void)
    
    /// Загрузить данные.
    func loadData (completion: @escaping ([GroupModel]) -> Void)
}
