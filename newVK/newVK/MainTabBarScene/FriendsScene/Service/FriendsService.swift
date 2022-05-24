//
//  FriendsService.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation
import RealmSwift

// MARK: - Error

/// Перечисления возможных ошибок.
enum FriendsServiceError: Error {
    /// Ошибка парсинга.
    case parseError
    /// Ошибка запроса.
    case requestError(Error)
    /// Ошибка при получении токена.
    case loadTokenError
}

/// Cервис сцены "Друзья".
final class FriendsService: FriendsServiceInput {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    
    // MARK: - FriendsServiceInput
    
    // Обновляем данные.
    func updateData(completion: @escaping (Bool) -> Void) {
        
        // Получаем токен текущего пользователя из синглтона "Session".
        guard let token = Session.instance.token else { return }
        
        /// Массив с параметрами запроса.
        let params: [String: String] = [
            "v": "5.131",
            "access_token": token,
            "fields": "photo_50"
        ]
        
        /// URL запроса друзей текущего пользователя.
        let url: URL = .configureFriendsURL(token: token,
                                            method: .friendsGet,
                                            httpMethod: .get,
                                            params: params)
        
        DispatchQueue.global(qos: .utility).async {
            // Извлекаем содержимое URL-адреса и вызывает обработчик по завершении.
            let task = self.session.dataTask(with: url) { data, _, error in
                
                guard let data = data, error == nil else {
                    if let error = error {
                        print(FriendsServiceError.requestError(error))
                    }
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FriendsResponce.self, from: data).response.items
                    
                    let updateFlag = self.saveDataInRealm(friends: result)
                    completion(updateFlag)
                    
                } catch {
                    print(FriendsServiceError.parseError)
                }
            }
            task.resume()
        }
    }
    
    // Загружаем данные.
    func loadData(completion: @escaping ([FriendModel]) -> Void) {
        let data = self.loadDataFromRealm()
        completion(data)
    }
}


// MARK: - Private
extension FriendsService {
    
    /// Сохранение данных в Realm.
    func saveDataInRealm(friends: [FriendModel]) -> Bool {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL ?? "")
            try realm.write {
                realm.add(friends, update: .modified)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return true
    }
    
    /// Загрузка данных из Realm.
    func loadDataFromRealm() -> [FriendModel] {
        var friends: [FriendModel] = []
        
        do {
            let realm = try Realm()
            let data = realm.objects(FriendModel.self)
            friends = Array(data)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        return friends
    }
}

// MARK: - URL

extension URL {
    
    /// Конфигурируем URL запрос.
    static func configureFriendsURL(token: String,
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
