//
//  ScoreViewController.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/18.
//

import UIKit
import SnapKit
import Toast

class LiveViewController: UIViewController {
    
    private lazy var presenter = LivePresenter(vc: self)
    
    private let inset: CGFloat = 16.0
    
    private lazy var calendar: UIDatePicker = {
        let calendar = UIDatePicker()
        calendar.preferredDatePickerStyle = .inline
        calendar.datePickerMode = .date
        
        calendar.addTarget(self, action: #selector(getDate), for: .valueChanged)
        
        return calendar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - (inset * 2), height: 80.0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = inset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(LiveListCollectionViewCell.self, forCellWithReuseIdentifier: LiveListCollectionViewCell.identifier)
        collectionView.isHidden = true
        
        collectionView.dataSource = presenter
        collectionView.delegate = presenter
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension LiveViewController: LiveProtocol {
    func setupNavigation() {
        navigationItem.title = "TODAY'S MATCH!!!"
        
        let calendar = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(tapCalendarButton))
        
        navigationItem.rightBarButtonItem = calendar
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    func setupViews() {
        [
            calendar,
            collectionView
        ].forEach {
            view.addSubview($0)
        }
        
        calendar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func searchDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        
        let selectedDate = dateFormatter.string(from: calendar.date)
        
        presenter.toggleItem()
        
        return selectedDate
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func pushLiveDetail(with result: Result) {
        let liveDetailViewController = LiveDetailViewController(result: result)
        
        guard let presentation = liveDetailViewController.presentationController as? UISheetPresentationController else { return }
        
        presentation.detents = [.medium()]
        present(liveDetailViewController, animated: true)
    }
    
    func makeToast() {
        view.makeToast("😭 경기 일정이 없습니다.")
    }
    
    func toggleItem() {
        collectionView.isHidden.toggle()
        calendar.isHidden.toggle()
    }
    
    @objc func getDate() {
        presenter.searchDate()
    }
    
    @objc func tapCalendarButton() {
        presenter.toggleItem()
    }
}
