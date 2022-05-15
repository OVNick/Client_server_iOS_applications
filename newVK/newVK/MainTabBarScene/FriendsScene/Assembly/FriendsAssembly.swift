//
//  FriendsAssembly.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import UIKit

/// Сборщик сцены "Друзья".
final class FriendsAssembly {
    /// Создать сцену "Друзья".
    /// - Returns: ViewController.
    static func makeFriendsListVC() -> UIViewController {
        let imageLoader = ImageLoaderHelper()
        let vc = FriendsViewController(imageProvider: imageLoader)
        let router = FriendsRouter(currentVC: vc)
        let interactor = FriendsInteractor()
        let presenter = FriendsPresenter(router: router, interactor: interactor)
        vc.output = presenter
        presenter.view = vc
        return vc
    }
}
