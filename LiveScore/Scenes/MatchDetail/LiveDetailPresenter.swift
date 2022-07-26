//
//  LiveDetailPresenter.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/07/12.
//

import UIKit

protocol LiveDetailProtocol: AnyObject {
    func setupViews(with result: Result)
}

class LiveDetailPresenter {
    private weak var vc: LiveDetailProtocol?
    
    private var result: Result
    
    init(vc: LiveDetailProtocol, result: Result) {
        self.vc = vc
        self.result = result
    }
    
    func viewDidLoad() {
        vc?.setupViews(with: result)
    }
}
