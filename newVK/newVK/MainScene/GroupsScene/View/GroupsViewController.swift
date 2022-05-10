//
//  GroupsViewController.swift
//  newVK
//
//  Created by Николай Онучин on 05.05.2022.
//

import UIKit

/// Входящий протокол сцены "Группы".
protocol GroupsViewInput: AnyObject {
    /// Установить группы в таблицу.
    func setGroups(groups: [GroupItemModel])
}

/// Контроллер сцены "Группы".
final class GroupsViewController: UIViewController {
    
    /// Массив групп.
    private var groups: [GroupItemModel] = []
    
    ///  Свойство, обрабатывающее исходящие события.
    var output: GroupsViewOutput?
    
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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupTableView()
        setupConstraints()
        output?.loadGroupsData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell") as? GroupCell
        else {
            return UITableViewCell()
        }
        
        let item = groups[indexPath.row]
        
        imageProvider.loadImage(url: item.icon) { image in
            cell.iconGroup = image
        }
        
        cell.configureCell(With: item)
        
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
        tableView.register(GroupCell.self, forCellReuseIdentifier: "GroupsCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.barTintColor = .white
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
}
