//
//  ImageLoaderService.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Протокол загрузки фото.
protocol ImageLoaderServiceProtocol {
    /// Загрузить фото.
    func loadImage(url: URL, completion: @escaping (Result<Data,Error>) -> ())
}

final class ImageLoaderService: ImageLoaderServiceProtocol {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()

    // Загружаем фото.
    func loadImage(url: URL, completion: @escaping (Result<Data,Error>) -> ()) {
        let completionOnMain: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        DispatchQueue.global(qos: .utility).async {
            self.session.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    if let error = error {
                        completionOnMain(.failure(error))
                    }
                    return
                }
                completionOnMain(.success(data))
            }.resume()
        }
    }
}
