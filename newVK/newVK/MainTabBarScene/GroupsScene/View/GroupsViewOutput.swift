//
//  GroupsViewOutput.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Исходящий протокол сцены "Группы".
protocol GroupsViewOutput {
    /// Загрузка групп в tableView.
    func loadGroups()
    /// Обновление данных о группах.
    func updateGroups()
}
