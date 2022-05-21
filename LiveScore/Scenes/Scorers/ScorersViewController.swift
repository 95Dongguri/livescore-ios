//
//  ScorersViewController.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import UIKit
import SnapKit

class ScorersViewController: UIViewController {

    private lazy var presenter = ScorersPresenter(vc: self)
    
    private let inset: CGFloat = 16.0
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(ScorersListTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: ScorersListTableViewHeaderView.identifier)
        
//        tableView.refreshControl = refreshControl

        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - (inset * 2), height: 120.0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = inset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.isHidden = true
        collectionView.register(ScorersListCollectionViewCell.self, forCellWithReuseIdentifier: ScorersListCollectionViewCell.identifier)
        
        collectionView.dataSource = presenter
        
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension ScorersViewController: ScorersProtocol {
    func setupNavigationTitle() {
        navigationItem.title = "LEAGUE TOP 10 SCORERS!!!"
    }
    
    func setupLayout() {
        [tableView, collectionView].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func isHidden(isHidden: Bool) {
        tableView.isHidden = isHidden
        collectionView.isHidden = !isHidden
    }
}

private extension ScorersViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
        isHidden(isHidden: false)
    }
}
