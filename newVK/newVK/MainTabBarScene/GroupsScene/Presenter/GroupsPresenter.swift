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

    /// Инициализатор сцены "Группы".
    init(interactor: GroupsInteractorInput) {
        self.interactor = interactor
    }
}
 

// MARK: - GroupsViewOutput

extension GroupsPresenter: GroupsViewOutput {
    
    // Загружаем группы.
    func loadGroups() {
        interactor.loadGroupsData { [weak self] groups in
            guard let self = self else { return }
            let items = self.formGroupsArray(from: groups)
            self.view?.setGroups(groups: items)
        }
    }
    
    // Обновление данных о группах, загрузка и установка в tableView.
    func updateGroups() {
        interactor.updateGroupsData { [weak self] updateFlag in
            guard let self = self else { return }
            if updateFlag {
                self.loadGroups()
            }
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

        var itemsArray = array.compactMap { group -> GroupItemModel in
            
            let model = GroupItemModel(title: group.name,
                                        icon: group.photo50)
            return model
        }
        
        // Cортируем друзей по алфавиту.
        itemsArray.sort(by: {$0.title < $1.title})
        
        return itemsArray
    }
}
