//
//  FriendsPresenter.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

final class FriendsPresenter {
    weak var view: FriendsViewInput?
    private let interactor: FriendsInteractorInput
    private let items: [FriendItemModel] = []

    init(interactor: FriendsInteractorInput) {
        self.interactor = interactor
    }
}
 
extension FriendsPresenter: FriendsViewOutput {
    func loadFriendsData() {
        interactor.loadFriends { [weak self] friends in
            guard let self = self else { return }
            let items = self.formFriendsArray(from: friends)
            self.view?.setFriends(friends: items)
            //self.view?.loadLetter()
        }
    }
}

private extension FriendsPresenter {
    func formFriendsArray(from array: [DTO.FriendsScene.Friend]?) -> [FriendItemModel] {
        guard let array = array else {
            return []
        }

       // var newArray: [Character: [FriendItemModel]] = [:]
       // var sectionsArray: [FriendSection] = []

        let newItemsArray = array.compactMap { friend -> FriendItemModel in
            let model = FriendItemModel(title: friend.firstName,
                                        subtitle: friend.lastName,
                                        icon: friend.photo50)
            return model
        }

//        for friend in newItemsArray {
//            guard let firstChar = friend.title.first else {
//                continue
//            }
//            guard var array = newArray[firstChar] else {
//                let newValue = [friend]
//                newArray.updateValue(newValue, forKey: firstChar)
//                continue
//            }
//            array.append(friend)
//            newArray.updateValue(array, forKey: firstChar)
//        }
//        newArray.forEach { key, array in
//            sectionsArray.append(FriendSection(key: key, data: array))
//        }
//        sectionsArray.sort { $0 < $1 }
        return newItemsArray
    }
}
