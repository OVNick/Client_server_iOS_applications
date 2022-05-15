//
//  PhotoViewInput.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import Foundation

/// Входящий протокол сцены "Фото".
protocol PhotoViewInput: AnyObject {
    /// Установить фото.
    func setPhoto(photo: [PhotoItemModel])
}
