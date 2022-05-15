//
//  PhotoInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import Foundation

/// Интерактор сцены "Фото".
final class PhotoInteractor {
    
    /// Свойство, отвечающее за сервисный слой сцены "Фото".
    private let service: PhotoServiceInput

    /// Инициализатор сервиного слоя сцены "Фото".
    init(service: PhotoServiceInput = PhotoService()) {
        self.service = service
    }
}


// MARK: - GroupsInteractorInput

extension PhotoInteractor: PhotoInteractorInput {
    // Загружаем фото.
    func loadPhoto(completion: @escaping ([DTO.PhotoScene.Photo]) -> Void) {
        service.loadPhoto { result in
            switch result {
            case .success(let photo):
                completion(photo)
            case .failure(_):
                return
            }
        }
    }
}
