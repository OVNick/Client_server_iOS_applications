//
//  FriendsRouter.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import UIKit

/// Роутер сцены "Друзья".
final class FriendsRouter {
    
    /// Текущий ViewController.
    private let currentVC: UIViewController
    
    /// Инициализатор.
    /// - Parameter currentVC: Текущий ViewController.
    init(currentVC: UIViewController) {
        self.currentVC = currentVC
    }
}


// MARK: - FriendsRouterInput

extension FriendsRouter: FriendsRouterInput {
    // Открываем следующую сцену.
    func openNextScene() {
        // Временный переход (сцена "Фото" будет заменена на сцену "Профиль пользователя")
        let nextVC = PhotoAssembly.makePhotoListVC()
        currentVC.navigationController?.pushViewController(nextVC, animated: true)
    }
}
