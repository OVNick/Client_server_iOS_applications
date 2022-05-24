//
//  FriendsViewOutput.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Исходящий протокол сцены "Друзья".
protocol FriendsViewOutput {
    ///  Обработать нажатие на ячейку.
    func cellTapAction(userId: Int)
    /// Загрузка друзей в tableView.
    func loadFriends()
    /// Обновление данных о друзьях.
    func updateFriends()
}
