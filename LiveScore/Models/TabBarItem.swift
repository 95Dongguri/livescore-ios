//
//  TabBarItem.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import UIKit

enum TabBarItem: CaseIterable {
    case live
    case scorers
    
    var title: String {
        switch self {
        case .live: return "Live"
        case .scorers: return "Scorers"
        }
    }
    
    var icon: (default: UIImage?, selected: UIImage?) {
        switch self {
        case .live: return (UIImage(systemName: "gamecontroller"), UIImage(systemName: "gamecontroller.fill"))
        case .scorers: return (UIImage(systemName: "crown"), UIImage(systemName: "crown.fill"))
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .live: return UINavigationController(rootViewController: LiveViewController())
        case .scorers: return UINavigationController(rootViewController: ScorersViewController())
        }
    }
}
