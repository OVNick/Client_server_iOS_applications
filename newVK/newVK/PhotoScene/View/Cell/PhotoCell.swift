//
//  PhotoCell.swift
//  newVK
//
//  Created by Николай Онучин on 12.05.2022.
//

import UIKit

/// Ячейка коллекции фото.
final class PhotoCell: UICollectionViewCell {
    
    var image: UIImage = UIImage() {
        didSet {
            photoImageView.image = image
        }
    }
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
            
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private

private extension PhotoCell {
    
    /// Устанавливаем Subview.
    func setupViews() {
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
}



