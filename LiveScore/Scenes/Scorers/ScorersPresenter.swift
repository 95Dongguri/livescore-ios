//
//  ScorersPresenter.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import UIKit

protocol ScorersProtocol: AnyObject {
    func setupNavigationTitle()
    func setupLayout()
    func reloadCollectionView()
    func isHidden(isHidden: Bool)
    func endRefreshing()
}

class ScorersPresenter: NSObject {
    
    private weak var vc: ScorersProtocol?
    private let scorersSearchManager: ScorersSearchManagerProtocol
    
    private var league = ""
    
    private let tags: [String] = ["WC", "CL", "BL1", "DED", "BSA", "PD", "FL1", "ELC", "PPL", "EC", "SA", "PL", "CLI"]
    
    private var scorerList: [Scorers] = []
    
    init(vc: ScorersProtocol, scorersSearchManager: ScorersSearchManagerProtocol = ScorersSearchManager()) {
        self.vc = vc
        self.scorersSearchManager = scorersSearchManager
    }
    
    func viewDidLoad() {
        vc?.setupNavigationTitle()
        vc?.setupLayout()
    }
    
    func didCalledRefresh() {
        vc?.isHidden(isHidden: false)
        vc?.endRefreshing()
    }
}

extension ScorersPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scorerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScorersListCollectionViewCell.identifier, for: indexPath) as? ScorersListCollectionViewCell else { return UICollectionViewCell() }
        
        let scores = scorerList[indexPath.row]
        cell.setup(scores: scores)
        
        return cell
    }
}

extension ScorersPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScorersListTableViewHeaderView.identifier) as? ScorersListTableViewHeaderView else { return UITableViewHeaderFooterView() }
        
        header.setup(tags: tags, delegate: self)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        return cell
    }
}

extension ScorersPresenter: UITableViewDelegate {
    
}

extension ScorersPresenter: ScorersListTableViewHeaderViewDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        league = tags[selectedIndex]
        scorerList = []
        
        scorersSearchManager.request(from: league) { [weak self] newValue in
            self?.scorerList += newValue
            self?.vc?.reloadCollectionView()
            self?.vc?.isHidden(isHidden: true)
        }
    }
}
