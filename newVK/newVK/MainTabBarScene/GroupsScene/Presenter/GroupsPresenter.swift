//
//  GroupsPresenter.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Презентер сцены "Группы".
final class GroupsPresenter {
    
    // Cсылки на другие модули.
    weak var view: GroupsViewInput?
    private let interactor: GroupsInteractorInput
    private let items: [GroupItemModel] = []

    init(interactor: GroupsInteractorInput) {
        self.interactor = interactor
    }
}
 

// MARK: - GroupsViewOutput

extension GroupsPresenter: GroupsViewOutput {
    
    // Загружаем группы.
    func loadGroupsData() {
        interactor.loadGroups { [weak self] groups in
            guard let self = self else { return }
            let items = self.formGroupsArray(from: groups)
            self.view?.setGroups(groups: items)
        }
    }
}


// MARK: - Private

private extension GroupsPresenter {
    
    /// Формирование массива групп.
    func formGroupsArray(from array: [GroupModel]?) -> [GroupItemModel] {
        
        guard let array = array else {
            return []
        }

        let newItemsArray = array.compactMap { group -> GroupItemModel in
            let model = GroupItemModel(title: group.name,
                                        icon: group.photo50)
            return model
        }
        
        return newItemsArray
    }
}
