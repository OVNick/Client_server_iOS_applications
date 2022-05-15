//
//  PhotoService.swift
//  newVK
//
//  Created by Николай Онучин on 12.05.2022.
//

import Foundation

// MARK: - Error

/// Перечисления возможных ошибок.
enum PhotoServiceError: Error {
    /// Ошибка парсинга.
    case parseError
    /// Ошибка запроса.
    case requestError(Error)
}

/// Сервис сцены "Фото".
final class PhotoService: PhotoServiceInput {
        
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    // MARK: - PhotoServiceInput
    
    // Загружаем фото пользователя.
    func loadPhoto(completion: @escaping ((Result<[DTO.PhotoScene.Photo], PhotoServiceError>) -> ())) {
        
        // Получаем токен текущего пользователя из синглтона "Session".
        guard let token = Session.instance.token else { return }
        let userId = String(DataManager.id)
        
        /// Массив с параметрами запроса.
        let params: [String: String] = [
            "owner_id": userId,
            "album_id": "profile",
            "v": "5.131",
            "access_token": token,
            "count": "200"
        ]
        
        /// URL запроса фото пользователя.
        let url: URL = .configurePhotoURL(token: token,
                                          method: .photoGet,
                                          httpMethod: .get,
                                          params: params)
        
        // Извлекаем содержимое URL-адреса и вызываем обработчик по завершении.
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                
                if let error = error {
                    completion(.failure(.requestError(error)))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(DTO.Response<DTO.PhotoScene.Photo>.self, from: data).response.items
                completion(.success(result))
            } catch {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}


// MARK: - URL

extension URL {
    
    /// Конфигурируем URL запрос.
    static func configurePhotoURL(token: String,
                                  method: Constants.Service.TypeMethods,
                                  httpMethod: Constants.Service,
                                  params: [String: String]) -> URL {
        var queryItems: [URLQueryItem] = []

        params.forEach { param, value in
            queryItems.append(URLQueryItem(name: param, value: value))
        }

        /// Конструктор URL.
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.Service.scheme.rawValue
        urlComponents.host = Constants.Service.host.rawValue
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            fatalError("URL is invalidate")
        }
        return url
    }
}
