//
//  ScorePresenter.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/18.
//

import UIKit

protocol ScoreProtocol: AnyObject {
    func setupNavigationTitle()
    func setupViews()
    func reloadCollectionView()
}

class ScorePresenter: NSObject {
    
    private weak var vc: ScoreProtocol?
    private let liveScoreSearchManager: LiveScoreSearchManagerProtocol

    private var dateFrom = ""
    
    private var resultList: [Result] = []
    
    init(vc: ScoreProtocol, liveScoreSearchManager: LiveScoreSearchManagerProtocol = LiveScoreSearchManager()) {
        self.vc = vc
        self.liveScoreSearchManager = liveScoreSearchManager
    }
    
    func viewDidLoad() {
        vc?.setupNavigationTitle()
        vc?.setupViews()
    }
}

extension ScorePresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScoreListCollectionViewCell.identifier, for: indexPath) as? ScoreListCollectionViewCell else { return UICollectionViewCell() }
        
        let result = resultList[indexPath.row]
        cell.setup(result: result)
        
        return cell
    }
}

extension ScorePresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resultList = []
        guard let searchDate = searchBar.text else { return }
        
        liveScoreSearchManager.request(from: searchDate) { [weak self] newValue in
            self?.resultList += newValue
            self?.vc?.reloadCollectionView()
        }
    }
}
