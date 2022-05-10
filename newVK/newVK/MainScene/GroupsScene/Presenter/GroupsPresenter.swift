//
//  GroupsPresenter.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Презентер сцены "Группы".
final class GroupsPresenter {
    weak var view: GroupsViewInput?
    private let interactor: GroupsInteractorInput
    private let items: [GroupItemModel] = []

    init(interactor: GroupsInteractorInput) {
        self.interactor = interactor
    }
}
 
// MARK: - GroupsViewOutput
extension GroupsPresenter: GroupsViewOutput {
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
    func formGroupsArray(from array: [DTO.GroupsScene.Group]?) -> [GroupItemModel] {
        guard let array = array else {
            return []
        }

        let newItemsArray = array.compactMap { groupe -> GroupItemModel in
            let model = GroupItemModel(title: groupe.name,
                                        icon: groupe.photo50)
            return model
        }
        
        return newItemsArray
    }
}
