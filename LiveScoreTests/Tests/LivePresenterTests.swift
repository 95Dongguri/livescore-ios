//
//  LivePresenterTests.swift
//  LiveScoreTests
//
//  Created by 김동혁 on 2022/05/24.
//

import XCTest

@testable import LiveScore

class LivePresenterTests: XCTestCase {
    
    var sut: LivePresenter!
    
    var vc: MockLiveViewController!
    var liveScoreSearchManager: MockLiveScoreSearchManager!
    
    override func setUp() {
        super.setUp()
        
        vc = MockLiveViewController()
        liveScoreSearchManager = MockLiveScoreSearchManager()
        
        sut = LivePresenter(vc: vc, liveScoreSearchManager: liveScoreSearchManager)
    }
    
    override func tearDown() {
        sut = nil
        
        liveScoreSearchManager = nil
        vc = nil
        
        super.tearDown()
    }
    
    func test_Called_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(vc.isCalledSetupNavigationTitle)
        XCTAssertTrue(vc.isCalledSetupViews)
    }
    
    func test_Called_searchBarSearchButtonClicked() {
        
        sut.searchBarSearchButtonClicked(UISearchBar())
        
        XCTAssertTrue(vc.isCalledReloadCollectionView)
        XCTAssertTrue(liveScoreSearchManager.isCalledRequest)
        XCTAssertTrue(vc.isCalledMakeToast)
    }
}
