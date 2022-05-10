//
//  FriendCell.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import UIKit

/// Ячейка таблицы друзей.
final class FriendCell: UITableViewCell {
    
    /// Изображение аватара друга.
    var iconFriend: UIImage = UIImage() {
        didSet {
            iconImageView.image = iconFriend
        }
    }
        
    /// Фон ячейки таблицы друзей.
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Аватар друга.
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Имя друга.
    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// Фамилия друга.
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Стек содержащий имя и фамилию друга.
    private lazy var stackLeftView: UIStackView = {
        let view = UIStackView()
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Инициализатор ячейки.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Конфигуратор ячейки.
    func configureCell(With model: FriendItemModel) {
        firstNameLabel.text = model.title
        lastNameLabel.text = model.subtitle
    }
}

// MARK: - Private
private extension FriendCell {
    func setupSubviews() {
        contentView.addSubview(backgroundCell)
        [firstNameLabel, lastNameLabel].forEach { stackLeftView.addArrangedSubview($0) }
        [iconImageView, stackLeftView].forEach { backgroundCell.addSubview($0) }
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            backgroundCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            backgroundCell.heightAnchor.constraint(equalToConstant: 80),
            
            iconImageView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: backgroundCell.leftAnchor, constant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 64),
            iconImageView.widthAnchor.constraint(equalToConstant: 64),
            
            stackLeftView.topAnchor.constraint(equalTo: backgroundCell.topAnchor),
            stackLeftView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16),
            stackLeftView.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor)
        ])
    }
}
