//
//  ScorersPresenterTests.swift
//  LiveScoreTests
//
//  Created by 김동혁 on 2022/05/24.
//

import XCTest
@testable import LiveScore

class ScorersPresenterTests: XCTestCase {
    
    var sut: ScorersPresenter!
    
    var vc: MockScorersViewController!
    var scorersSearchManager: MockScorersSearchManager!
    
    override func setUp() {
        super.setUp()
        
        vc = MockScorersViewController()
        scorersSearchManager = MockScorersSearchManager()
        
        sut = ScorersPresenter(vc: vc, scorersSearchManager: scorersSearchManager)
    }
    
    override func tearDown() {
        sut = nil
        
        scorersSearchManager = nil
        vc = nil
        
        super.tearDown()
    }
    
    func test_Called_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(vc.isCalledSetupNavigationTitle)
        XCTAssertTrue(vc.isCalledSetupLayout)
    }
    
    func test_Called_didCalledRefresh() {
        sut.didCalledRefresh()
        
        XCTAssertTrue(vc.isCalledIsHidden)
        XCTAssertTrue(vc.isCalledEndRefreshing)
    }
    
    func test_Called_didSelectTag() {
        sut.didSelectTag(0)
        
        XCTAssertTrue(scorersSearchManager.isCalledRequest)
        XCTAssertTrue(vc.isCalledReloadCollectionView)
        XCTAssertTrue(vc.isCalledIsHidden)
    }
}
