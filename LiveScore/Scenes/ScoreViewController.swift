//
//  ScoreViewController.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/18.
//

import UIKit
import SnapKit

class ScoreViewController: UIViewController {
    
    private lazy var presenter = ScorePresenter(vc: self)
    
    private let inset: CGFloat = 16.0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - (inset * 2), height: 60.0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = inset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(ScoreListCollectionViewCell.self, forCellWithReuseIdentifier: ScoreListCollectionViewCell.identifier)
        
        collectionView.dataSource = presenter
        
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension ScoreViewController: ScoreProtocol {
    func setupNavigationTitle() {
        navigationItem.title = "TODAY'S MATCH!!!"
    }
    
    func setupViews() {
//        let searchController = UISearchController()
//        searchController.searchBar.placeholder = "좋아하는 리그를 검색해주세요."
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.delegate = presenter
//
//        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}
