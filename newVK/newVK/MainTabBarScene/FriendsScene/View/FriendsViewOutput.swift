//
//  FriendsViewOutput.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Исходящий протокол сцены "Друзья".
protocol FriendsViewOutput {
    /// Загрузить друзей.
    func loadFriendsData()
    ///  Обработать нажатие на ячейку.
    func cellTapAction(userId: Int)
}
