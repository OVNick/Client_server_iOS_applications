//
//  GroupCell.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import UIKit

/// Ячейка таблицы групп.
final class GroupCell: UITableViewCell {
    
    /// Изображение аватара группы.
    var iconGroup: UIImage = UIImage() {
        didSet {
            iconImageView.image = iconGroup
        }
    }
        
    /// Фон ячейки таблицы групп.
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Аватар группы.
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Название группы.
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    func configureCell(With model: GroupItemModel) {
        nameLabel.text = model.title
    }
}


// MARK: - Private

private extension GroupCell {
    
    /// Устанавливаем Subview.
    func setupSubviews() {
        
        contentView.addSubview(backgroundCell)
        [iconImageView, nameLabel].forEach { backgroundCell.addSubview($0) }
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            backgroundCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            backgroundCell.heightAnchor.constraint(equalToConstant: 64),
            
            iconImageView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: backgroundCell.leftAnchor, constant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            
            nameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: backgroundCell.rightAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor)
        ])
    }
}
