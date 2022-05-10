//
//  FriendsPresenter.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Презентер сцены "Друзья".
final class FriendsPresenter {
    weak var view: FriendsViewInput?
    private let interactor: FriendsInteractorInput
    private let items: [FriendItemModel] = []

    init(interactor: FriendsInteractorInput) {
        self.interactor = interactor
    }
}
 
// MARK: - FriendsViewOutput
extension FriendsPresenter: FriendsViewOutput {
    func loadFriendsData() {
        interactor.loadFriends { [weak self] friends in
            guard let self = self else { return }
            let items = self.formFriendsArray(from: friends)
            self.view?.setFriends(friends: items)
        }
    }
}

// MARK: - Private
private extension FriendsPresenter {
    func formFriendsArray(from array: [DTO.FriendsScene.Friend]?) -> [FriendItemModel] {
        guard let array = array else {
            return []
        }

        let newItemsArray = array.compactMap { friend -> FriendItemModel in
            let model = FriendItemModel(title: friend.firstName,
                                        subtitle: friend.lastName,
                                        icon: friend.photo50)
            return model
        }
        
        return newItemsArray
    }
}
