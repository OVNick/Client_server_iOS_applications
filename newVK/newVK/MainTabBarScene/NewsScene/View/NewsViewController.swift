//
//  NewsViewController.swift
//  newVK
//
//  Created by Николай Онучин on 05.05.2022.
//

import UIKit

final class NewsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Временно
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
}
