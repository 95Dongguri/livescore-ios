//
//  ScorersListTableViewHeaderView.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import UIKit
import TTGTags
import SnapKit

protocol ScorersListTableViewHeaderViewDelegate: AnyObject {
    func didSelectTag(_ selectedIndex: Int)
}

class ScorersListTableViewHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "ScorersListTableViewHeaderView"
    
    private weak var delegate: ScorersListTableViewHeaderViewDelegate?
    
    private var tags: [String] = []
    
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    
    func setup(tags: [String], delegate: ScorersListTableViewHeaderViewDelegate) {
        self.tags = tags
        self.delegate = delegate
        
        contentView.backgroundColor = .systemBackground
        
        setupTagCollectionViewLayout()
        setupTagCollectionView()
    }
}

extension ScorersListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        guard tag.selected else { return }
        
        delegate?.didSelectTag(Int(index))
    }
}

private extension ScorersListTableViewHeaderView {
    func setupTagCollectionViewLayout() {
        addSubview(tagCollectionView)
        
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupTagCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.numberOfLines = 1
        tagCollectionView.scrollDirection = .horizontal
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.selectionLimit = 1
        
        let inset: CGFloat = 16.0
        
        tagCollectionView.contentInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        let style = TTGTextTagStyle()
        style.backgroundColor = .systemOrange
        style.cornerRadius = 12.0
        style.borderWidth = 0.0
        style.shadowOpacity = 0.0
        style.extraSpace = CGSize(width: 20.0, height: 12.0)
        
        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = .white
        selectedStyle.cornerRadius = 12.0
        selectedStyle.shadowOpacity = 0.0
        selectedStyle.extraSpace = CGSize(width: 20.0, height: 12.0)
        selectedStyle.borderColor = .systemOrange
        
        tags.forEach { tag in
            let tagContents = TTGTextTagStringContent(text: tag, textFont: .systemFont(ofSize: 14.0, weight: .semibold), textColor: .white)
            let selectedTagContents = TTGTextTagStringContent(text: tag, textFont: .systemFont(ofSize: 14.0, weight: .semibold), textColor: .systemOrange)
            
            let tag = TTGTextTag(content: tagContents, style: style, selectedContent: selectedTagContents, selectedStyle: selectedStyle)
            
            tagCollectionView.addTag(tag)
        }
    }
}
