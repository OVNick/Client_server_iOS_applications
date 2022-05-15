//
//  PhotoServiceInput.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import Foundation

/// Входящий протокол сервиса сцены "Фото".
protocol PhotoServiceInput {
    /// Загрузить фото выбранного пользователя.
    func loadPhoto(completion: @escaping ((Result<[DTO.PhotoScene.Photo], PhotoServiceError>) -> ()))
}
