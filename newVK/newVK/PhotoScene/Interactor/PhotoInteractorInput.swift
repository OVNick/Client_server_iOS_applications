//
//  PhotoInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import Foundation

/// Входящий протокол интерактора  сцены "Фото".
protocol PhotoInteractorInput {
    /// Загрузить фото.
    func loadPhoto(completion: @escaping ([DTO.PhotoScene.Photo]) -> Void)
}
