//
//  GroupsAssembly.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import UIKit

/// Сборщик сцены "Группы".
final class GroupsAssembly {
    /// Создем сцену "Группы".
    /// - Returns: ViewController.
    static func makeGroupsListVC() -> UIViewController {
        let imageLoader = ImageLoaderHelper()
        let vc = GroupsViewController(imageProvider: imageLoader)
        let interactor = GroupsInteractor()
        let presenter = GroupsPresenter(interactor: interactor)
        
        vc.output = presenter
        presenter.view = vc
        
        return vc
    }
}
