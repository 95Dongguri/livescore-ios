//
//  ScoreViewController.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/18.
//

import UIKit
import SnapKit

class LiveViewController: UIViewController {
    
    private lazy var presenter = LivePresenter(vc: self)
    
    private let inset: CGFloat = 16.0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - (inset * 2), height: 80.0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = inset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(LiveListCollectionViewCell.self, forCellWithReuseIdentifier: LiveListCollectionViewCell.identifier)
        
        collectionView.dataSource = presenter
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension LiveViewController: LiveProtocol {
    func setupNavigationTitle() {
        navigationItem.title = "TODAY'S MATCH!!!"
    }
    
    func setupViews() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "날짜를 입력해주세요. (yyyy-MM-dd)"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter

        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}
