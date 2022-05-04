//
//  LoginRouter.swift
//  newVK
//
//  Created by Николай Онучин on 04.05.2022.
//

import UIKit

/// Входящий протокол роутера формы авторизации.
protocol LoginRouterInput {
    /// Открыть главную сцену.
    func openMainScene()
}

/// Роутер формы авторизации.
final class LoginRouter {
    
    /// Текущий ViewController.
    private let currentVC: UIViewController

    /// Инициализатор.
    /// - Parameter currentVC: Текущий ViewController.
    init(currentVC: UIViewController) {
        self.currentVC = currentVC
    }
}

// MARK: - LoginRouterInput
extension LoginRouter: LoginRouterInput {
    // Открываем главную сцену.
    func openMainScene() {
        let nextVC = MainTabBarViewController()
        currentVC.navigationController?.pushViewController(nextVC, animated: true)
    }
}
