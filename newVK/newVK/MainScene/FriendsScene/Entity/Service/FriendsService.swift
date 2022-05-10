//
//  FriendsService.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Перечисления возможных ошибок.
enum FriendsServiceError: Error {
    /// Ошибка парсинга.
    case parseError
    /// Ошибка запроса.
    case requestError(Error)
}

/// Входящий протокол сервиса сцены "Друзья".
protocol FriendsServiceInput {
    /// Загрузить друзей текущего пользователя.
    func loadFriends(completion: @escaping ((Result<[DTO.FriendsScene.Friend], FriendsServiceError>) -> ()))
}

final class FriendsService: FriendsServiceInput {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()

    // Загружаем друзей текущего пользователя.
    func loadFriends(completion: @escaping ((Result<[DTO.FriendsScene.Friend], FriendsServiceError>) -> ())) {
        
        // Получаем токен текущего пользователя из синглтона "Session".
        guard let token = Session.instance.token else { return }
        
        /// Массив с параметрами запроса.
        let params: [String: String] = [
            "v": "5.131",
            "access_token": token,
            "fields": "photo_50"
        ]
        
        /// URL запроса друзей текущего пользователя.
        let url: URL = .configureURL(token: token,
                                     method: .friendsGet,
                                     httpMethod: .get,
                                     params: params)

        // Извлекает содержимое URL-адреса и вызывает обработчик по завершении.
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(.requestError(error)))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(DTO.Response<DTO.FriendsScene.Friend>.self, from: data).response.items
                completion(.success(result))
            } catch {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}


extension URL {
    /// Конфигурируем URL запрос.
    static func configureURL(token: String,
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
