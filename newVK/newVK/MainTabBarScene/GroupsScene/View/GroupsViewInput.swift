//
//  GroupsViewInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation

/// Входящий протокол сцены "Группы".
protocol GroupsViewInput: AnyObject {
    /// Установить группы в таблицу.
    func setGroups(groups: [GroupItemModel])
}
