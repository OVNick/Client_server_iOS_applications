//
//  GroupsService.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Перечисления возможных ошибок.
enum GroupsServiceError: Error {
    /// Ошибка парсинга.
    case parseError
    /// Ошибка запроса.
    case requestError(Error)
}

/// Входящий протокол сервиса сцены "Группы".
protocol GroupsServiceInput {
    /// Загрузить группы текущего пользователя.
    func loadGroups(completion: @escaping ((Result<[DTO.GroupsScene.Group], GroupsServiceError>) -> ()))
}

final class GroupsService: GroupsServiceInput {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()

    // Загружаем группы текущего пользователя.
    func loadGroups(completion: @escaping ((Result<[DTO.GroupsScene.Group], GroupsServiceError>) -> ())) {
        
        // Получаем токен текущего пользователя из синглтона "Session".
        guard let token = Session.instance.token else { return }
        
        print("token: \(token)")
        
        /// Массив с параметрами запроса.
        let params: [String: String] = [
            "v": "5.131",
            "access_token": token,
            "extended": "1",
            "fields": "photo_50"
        ]
        
        /// URL запроса групп текущего пользователя.
        let url: URL = .configureGroupsURL(token: token,
                                           method: .groupsGet,
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
                let result = try JSONDecoder().decode(DTO.Response<DTO.GroupsScene.Group>.self, from: data).response.items
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
    static func configureGroupsURL(token: String,
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
