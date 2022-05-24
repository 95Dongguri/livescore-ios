//
//  MockScorersViewController.swift
//  LiveScoreTests
//
//  Created by 김동혁 on 2022/05/24.
//

import Foundation
@testable import LiveScore

class MockScorersViewController: ScorersProtocol {
    
    var isCalledSetupNavigationTitle = false
    var isCalledSetupLayout = false
    var isCalledReloadCollectionView = false
    var isCalledIsHidden = false
    var isCalledEndRefreshing = false
    
    func setupNavigationTitle() {
        isCalledSetupNavigationTitle = true
    }
    
    func setupLayout() {
        isCalledSetupLayout = true
    }
    
    func reloadCollectionView() {
        isCalledReloadCollectionView = true
    }
    
    func isHidden(isHidden: Bool) {
        isCalledIsHidden = true
    }
    
    func endRefreshing() {
        isCalledEndRefreshing = true
    }
}
