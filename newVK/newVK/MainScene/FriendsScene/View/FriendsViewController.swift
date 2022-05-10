//
//  FriendsViewController.swift
//  newVK
//
//  Created by Николай Онучин on 05.05.2022.
//

import UIKit

/// Входящий протокол сцены "Друзья".
protocol FriendsViewInput: AnyObject {
    /// Установить друзей в таблицу.
    func setFriends(friends: [FriendItemModel])
}

/// Контроллер сцены "Друзья".
final class FriendsViewController: UIViewController {
    
    /// Массив друзей.
    private var friends: [FriendItemModel] = []
    
    ///  Свойство, обрабатывающее исходящие события.
    var output: FriendsViewOutput?
    
    private let imageProvider: ImageLoaderHelperProtocol

    init(imageProvider: ImageLoaderHelperProtocol) {
        self.imageProvider = imageProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Таблица для отображения друзей.
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupConstraints()
        output?.loadFriendsData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as? FriendCell
        else {
            return UITableViewCell()
        }
        
        let item = friends[indexPath.row]
        
        imageProvider.loadImage(url: item.icon) { image in
            cell.iconFriend = image
        }
        
        cell.configureCell(With: item)
        
        return cell
    }
}


// MARK: - FriendsViewInput
extension FriendsViewController: FriendsViewInput {
    // Устанавливаем друзей в таблицу.
    func setFriends(friends: [FriendItemModel]) {
        self.friends = friends
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Private
private extension FriendsViewController {
    
    /// Настройка и установка таблицы друзей.
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.frame = self.view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendsCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.barTintColor = .white
        view.addSubview(tableView)
    }
    
    /// Установка констрейнтов для таблицы друзей.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
