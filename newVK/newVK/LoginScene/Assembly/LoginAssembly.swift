//
//  LoginViewAssembly.swift
//  newVK
//
//  Created by Николай Онучин on 04.05.2022.
//

import UIKit

/// Сборщик сцены авторизации.
final class LoginAssembly {
    /// Создать сцену авторизации.
    /// - Returns: ViewController.
    static func makeLoginScene() -> UIViewController {
        let vc = LoginViewController()
        let router = LoginRouter(currentVC: vc)
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(router: router, interactor: interactor)
        vc.output = presenter
        presenter.view = vc
        return vc
    }
}
