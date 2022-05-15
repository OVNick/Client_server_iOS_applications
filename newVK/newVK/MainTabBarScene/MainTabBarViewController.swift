//
//  MainTabBarViewController.swift
//  newVK
//
//  Created by Николай Онучин on 04.05.2022.
//

import UIKit

/// Главный экран приложения с таббаром.
final class MainTabBarViewController: UITabBarController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        makeTabItems()
    }
}


// MARK: - Private

private extension MainTabBarViewController {
    
    /// Настройка TabBar.
    func setupTabbar() {
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
    }
    
    /// Сборка панели вкладок (TabBar)
    func makeTabItems() {
        
        // Формируем изображения для представления вкладок.
        guard let friendIcon = UIImage(systemName: "person.2") else { return }
        guard let newsIcon = UIImage(systemName: "note") else { return }
        guard let groupsIcon = UIImage(systemName: "person.3") else { return }
        
        let friendsAssembly = FriendsAssembly.makeFriendsListVC()
        let groupsAssembly = GroupsAssembly.makeGroupsListVC()
        
        // Cоздаем элементы панели вкладок.
        let friends = createNavController(for: friendsAssembly,
                                          title: "Друзья",
                                          image: friendIcon)
        
        let news = createNavController(for: NewsViewController(),
                                          title: "Новости",
                                          image: newsIcon)

        let groups = createNavController(for: groupsAssembly,
                                          title: "Группы",
                                          image: groupsIcon)
                
        // Формируем массив контроллеров корневого представления панели вкладок.
        viewControllers = [friends, news, groups]
    }
    
    /// Создание элементов панели вкладок.
    /// - Parameters:
    ///   - rootViewController: Корневой View.
    ///   - title: Название вкладки.
    ///   - image: Изображение для представления вкладки.
    func createNavController(for rootViewController: UIViewController,
                             title: String,
                             image: UIImage?
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
}
