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
    func reloadData()
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
}

extension ScorersPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scorerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScorersListTableViewCell.identifier, for: indexPath) as? ScorersListTableViewCell else { return UITableViewCell() }
        
        let scorers = scorerList[indexPath.row]
        
        cell.setup(scorers: scorers)

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScorersListTableViewHeaderView.identifier) as? ScorersListTableViewHeaderView else { return UITableViewHeaderFooterView() }
        
        header.setup(tags: tags, delegate: self)
        
        return header
    }
}

extension ScorersPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath) select")
    }
}

extension ScorersPresenter: ScorersListTableViewHeaderViewDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        league = tags[selectedIndex]
        requestScorersList()
    }
}

private extension ScorersPresenter {
    func requestScorersList() {
        scorersSearchManager.request(from: league) { [weak self] newValue in
            self?.scorerList = newValue
            self?.vc?.reloadData()
        }
    }
}
