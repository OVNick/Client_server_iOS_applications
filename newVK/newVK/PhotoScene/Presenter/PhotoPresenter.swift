//
//  PhotoPresenter.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import Foundation

/// Презентер сцены "Фото".
final class PhotoPresenter {
    
    // Ссылки на другие модули.
    weak var view: PhotoViewInput?
    private let interactor: PhotoInteractorInput
    private let items: [PhotoItemModel] = []

    /// Инициализатор сцены "Фото".
    init(interactor: PhotoInteractorInput) {
        self.interactor = interactor
    }
}


// MARK: - PhotoViewOutput

extension PhotoPresenter: PhotoViewOutput {
    
    // Загружаем фото.
    func loadPhotoData() {
        interactor.loadPhoto { [weak self] photo in
            guard let self = self else { return }
            let items = self.formPhotoArray(from: photo)
            self.view?.setPhoto(photo: items)
        }
    }
}


// MARK: - Private

private extension PhotoPresenter {
    
    /// Формируем массив фото.
    func formPhotoArray(from array: [DTO.PhotoScene.Photo]?) -> [PhotoItemModel] {
        
        guard let array = array else {
            return []
        }

        let itemsArray = array.compactMap { photo -> PhotoItemModel in
            guard
                let urlPhoto = photo.sizes.last?.url
            else {
                return PhotoItemModel(icon: "")
            }
            
            let model = PhotoItemModel(icon: urlPhoto)
            return model
        }
        
        return itemsArray
    }
}
