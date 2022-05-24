//
//  GroupsService.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation
import RealmSwift

// MARK: - Error

/// Перечисления возможных ошибок.
enum GroupsServiceError: Error {
    /// Ошибка парсинга.
    case parseError
    /// Ошибка запроса.
    case requestError(Error)
}

/// Сервис сцены "Группы".
final class GroupsService: GroupsServiceInput {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    
    // MARK: - GroupsServiceInput
    
    // Обновляем данные.
    func updateData(completion: @escaping (Bool) -> Void) {
        
        // Получаем токен текущего пользователя из синглтона "Session".
        guard let token = Session.instance.token else { return }
        
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
        
        DispatchQueue.global(qos: .utility).async {
            // Извлекаем содержимое URL-адреса и вызывает обработчик по завершении.
            let task = self.session.dataTask(with: url) { data, _, error in
                
                guard let data = data, error == nil else {
                    if let error = error {
                        print(GroupsServiceError.requestError(error))
                    }
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GroupResponce.self, from: data).response.items
                    
                    let updateFlag = self.saveDataInRealm(groups: result)
                    completion(updateFlag)
                    
                } catch {
                    print(GroupsServiceError.parseError)
                }
            }
            task.resume()
        }
    }
    
    // Загружаем данные.
    func loadData(completion: @escaping ([GroupModel]) -> Void) {
        let data = self.loadDataFromRealm()
        completion(data)
    }
}


// MARK: - Private

extension GroupsService {
    
    /// Сохранение данных в Realm.
    func saveDataInRealm(groups: [GroupModel]) -> Bool {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL ?? "")
            try realm.write {
                realm.add(groups, update: .modified)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return true
    }
    
    /// Загрузка данных из Realm.
    func loadDataFromRealm() -> [GroupModel] {
        var groups: [GroupModel] = []
        
        do {
            let realm = try Realm()
            let data = realm.objects(GroupModel.self)
            groups = Array(data)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        return groups
    }
}

// MARK: - URL

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
