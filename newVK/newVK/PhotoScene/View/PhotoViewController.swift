//
//  PhotoViewController.swift
//  newVK
//
//  Created by Николай Онучин on 12.05.2022.
//

import UIKit

/// Контроллер сцены "Фото".
final class PhotoViewController: UIViewController {
    
    /// Идентификатор ячейки.
    let cellIdentifire = "PhotoCell"
    
    /// Массив фото.
    private var photo: [PhotoItemModel] = []
    
    ///  Свойство, обрабатывающее исходящие события.
    var output: PhotoViewOutput?
    
    private let imageProvider: ImageLoaderHelperProtocol
    
    init(imageProvider: ImageLoaderHelperProtocol) {
        self.imageProvider = imageProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Колекция для отображения фото.
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.itemSize.width = view.bounds.width/3-2
        layout.itemSize.height = view.bounds.width/3-2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupСollectionView()
        setupConstraints()
        output?.loadPhotoData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as? PhotoCell
        else {
            preconditionFailure("Error")
        }
        
        cell.contentMode = .scaleAspectFit
        
        let item = photo[indexPath.row]
        
        imageProvider.loadImage(url: item.icon) { image in
            cell.image = image
        }
        
        return cell
    }
    
    // Задаем размеры ячейки.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3 - 3), height: (view.frame.width / 3 - 3))
    }
    
    // Задаем отступы.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
}


// MARK: - PhotoViewInput
extension PhotoViewController: PhotoViewInput {
    // Устанавливаем фото.
    func setPhoto(photo: [PhotoItemModel]) {
        self.photo = photo
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


// MARK: - Private
private extension PhotoViewController {
    
    /// Настройка и установка коллекции.
    func setupСollectionView() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellIdentifire)
        collectionView.backgroundColor = .white
        collectionView.frame = self.view.bounds
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "Фотографии"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        view.addSubview(collectionView)
    }
    
    /// Установка констрейнтов для коллекции.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
