//
//  PhotoAssembly.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import UIKit

/// Сборщик сцены "Фото".
final class PhotoAssembly {
    static func makePhotoListVC() -> UIViewController {
        let imageLoader = ImageLoaderHelper()
        let vc = PhotoViewController(imageProvider: imageLoader)
        let interactor = PhotoInteractor()
        let presenter = PhotoPresenter(interactor: interactor)
        
        vc.output = presenter
        presenter.view = vc
        
        return vc
    }
}
