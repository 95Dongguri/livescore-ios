//
//  MockLiveViewController.swift
//  LiveScoreTests
//
//  Created by 김동혁 on 2022/05/24.
//

import Foundation
@testable import LiveScore

class MockLiveViewController: LiveProtocol {

    var isCalledSetupNavigationTitle = false
    var isCalledSetupViews = false
    var isCalledReloadCollectionView = false
    var isCalledMakeToast = false
    
    func setupNavigationTitle() {
        isCalledSetupNavigationTitle = true
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func reloadCollectionView() {
        isCalledReloadCollectionView = true
    }
    
    func makeToast() {
        isCalledMakeToast = true
    }
}
