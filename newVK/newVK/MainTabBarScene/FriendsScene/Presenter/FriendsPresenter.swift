//
//  FriendsPresenter.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Презентер сцены "Друзья".
final class FriendsPresenter {
    
    // Ссылки на элементы модуля.
    weak var view: FriendsViewInput?
    private let router: FriendsRouterInput
    private let interactor: FriendsInteractorInput
    private let items: [FriendItemModel] = []
    
    /// Инициализатор сцены "Друзья".
    init(router: FriendsRouterInput,
         interactor: FriendsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}


// MARK: - FriendsViewOutput

extension FriendsPresenter: FriendsViewOutput {
    
    // Загрузка друзей и установка в tabelView.
    func loadFriends() {
        interactor.loadFriendsData { [weak self] friends in
            guard let self = self else { return }
            let items = self.formFriendsArray(from: friends)
            self.view?.setFriends(friends: items)
        }
    }
    
    // Обновление данных о друзьях, загрузка и установка в tableView.
    func updateFriends() {
        interactor.updateFriendsData { [weak self] updateFlag in
            guard let self = self else { return }
            if updateFlag {
                self.loadFriends()
            }
        }
    }
    
    // Обрабатываем нажатие на ячейку.
    func cellTapAction(userId: Int) {
        // Сохраняем id выбранного пользователя в DataManager.
        interactor.loadId(userId: userId)
        // Переходим на следующую сцену.
        router.openNextScene()
    }
}


// MARK: - Private

private extension FriendsPresenter {
    
    /// Формирование массива друзей.
    func formFriendsArray(from array: [FriendModel]?) -> [FriendItemModel] {
        
        guard let array = array else {
            return []
        }
        
        var itemsArray = array.compactMap { friend -> FriendItemModel in
            
            let model = FriendItemModel(id: friend.id,
                                        title: friend.firstName,
                                        subtitle: friend.lastName,
                                        icon: friend.photo50)
            return model
        }
        
        // Cортируем друзей по алфавиту.
        itemsArray.sort(by: {$0.title < $1.title})
        
        return itemsArray
    }
}
