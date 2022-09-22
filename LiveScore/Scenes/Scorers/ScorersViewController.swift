//
//  ScorersViewController.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import UIKit
import SnapKit
import Toast

class ScorersViewController: UIViewController {

    private lazy var presenter = ScorersPresenter(vc: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 120.0
        tableView.separatorInset.left = 0.0

        tableView.dataSource = presenter
        tableView.delegate = presenter

        tableView.register(ScorersListTableViewCell.self, forCellReuseIdentifier: ScorersListTableViewCell.identifier)
        tableView.register(ScorersListTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: ScorersListTableViewHeaderView.identifier)
                
        return tableView
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
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func makeToast() {
        view.makeToast("😭 득점 순위가 없습니다.")
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
