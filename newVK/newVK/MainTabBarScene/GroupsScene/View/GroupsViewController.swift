//
//  GroupsViewController.swift
//  newVK
//
//  Created by Николай Онучин on 05.05.2022.
//

import UIKit
import RealmSwift

/// Контроллер сцены "Группы".
final class GroupsViewController: UIViewController {
    
    /// Идентификатор ячейки.
    let cellIdentifire = "GroupsCell"
    
    /// Массив групп.
    private var groups: [GroupItemModel] = []
    
    ///  Свойство, обрабатывающее исходящие события.
    var output: GroupsViewOutput?
    
    let realm = RealmCacheService()

    private var groupsRespons: Results<GroupModel>? {
        realm.read(GroupModel.self)
    }

    private var notificationToken: NotificationToken?
    
    private let imageProvider: ImageLoaderHelperProtocol

    init(imageProvider: ImageLoaderHelperProtocol) {
        self.imageProvider = imageProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Таблица для отображения групп.
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    /// refreshControl для обновления таблицы групп.
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    /// Обновление таблицы групп.
    @objc private func refresh(sender: UIRefreshControl) {
        output?.updateGroups()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        sender.endRefreshing()
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupTableView()
        setupConstraints()
        output?.loadGroups()
        createNotificationToken()
        tableView.refreshControl = refreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Обновление данных о друзьях.
        output?.updateGroups()
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsRespons?.count ?? 0 //groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as? GroupCell
        else {
            return UITableViewCell()
        }
        
        if let groups = groupsRespons {
            imageProvider.loadImage(url: groups[indexPath.row].photo50) { image in
                cell.iconGroup = image
            }
            cell.configureCellForRealm(with: groups[indexPath.row])
        }
        
//        let item = groups[indexPath.row]
//
//        imageProvider.loadImage(url: item.icon) { image in
//            cell.iconGroup = image
//        }
//
//        cell.configureCell(With: item)
        
        return cell
    }
}


// MARK: - GroupsViewInput

extension GroupsViewController: GroupsViewInput {
    
    // Устанавливаем группы в таблицу.
    func setGroups(groups: [GroupItemModel]) {
        self.groups = groups
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


// MARK: - Private

private extension GroupsViewController {
    
    /// Настройка и установка таблицы групп.
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.frame = self.view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(GroupCell.self, forCellReuseIdentifier: cellIdentifire)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        view.addSubview(tableView)
    }
    
    /// Установка констрейнтов для таблицы групп.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func createNotificationToken() {
        notificationToken = groupsRespons?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let groupsData):
                print("\(groupsData.count)")
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                let deletionsIndexpath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexpath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexpath = modifications.map { IndexPath(row: $0, section: 0) }

                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletionsIndexpath, with: .automatic)
                    self.tableView.insertRows(at: insertionsIndexpath, with: .automatic)
                    self.tableView.reloadRows(at: modificationsIndexpath, with: .automatic)
                    self.tableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
}
