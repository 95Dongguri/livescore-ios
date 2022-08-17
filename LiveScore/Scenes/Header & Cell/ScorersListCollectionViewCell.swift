//
//  ScorersListCollectionViewCell.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import SDWebImageSVGCoder
import SnapKit
import UIKit

class ScorersListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ScorersListCollectionViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var birthLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var nationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = .systemRed
        
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = .systemRed
        
        return label
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 0.3
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private lazy var goalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var assistsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var penaltiesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    func setup(scores: Scorers) {
        setupLayout()
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        guard let url = URL(string: scores.team.crest ?? "") else { return }
        
        logoView.sd_setImage(with: url)
        
        var rect = logoView.frame
        
        rect.size.width = 80.0
        rect.size.height = 80.0
        
        logoView.frame = rect
        
        nameLabel.text = scores.player.name
        birthLabel.text = scores.player.dateOfBirth
        nationLabel.text = "Nation: \(scores.player.nationality)"
        positionLabel.text = "Position: \(scores.player.position)"
        
        teamNameLabel.text = scores.team.name
        
        goalLabel.text = "Goals: \(scores.goals ?? 0)"
        assistsLabel.text = "Assists: \(scores.assists ?? 0)"
        penaltiesLabel.text = "Penalties: \(scores.penalties ?? 0)"
    }
}

extension ScorersListCollectionViewCell {
    func setupLayout() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        [
            logoView,
            nameLabel,
            birthLabel,
            nationLabel,
            positionLabel,
            teamNameLabel,
            goalLabel,
            assistsLabel,
            penaltiesLabel
        ].forEach {
            addSubview($0)
        }
        
        logoView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(80.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.top)
            $0.leading.equalTo(logoView.snp.trailing).offset(16.0)
        }
        
        birthLabel.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.top)
            $0.trailing.equalToSuperview().inset(12.0)
        }
        
        nationLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5.0)
        }
        
        positionLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nationLabel.snp.bottom).offset(5.0)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(logoView)
            $0.top.equalTo(logoView.snp.bottom).offset(5.0)
        }
        
        goalLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(teamNameLabel.snp.top)
        }
        
        assistsLabel.snp.makeConstraints {
            $0.leading.equalTo(goalLabel.snp.trailing).offset(5.0)
            $0.top.equalTo(teamNameLabel.snp.top)
        }
        
        penaltiesLabel.snp.makeConstraints {
            $0.leading.equalTo(assistsLabel.snp.trailing).offset(5.0)
            $0.top.equalTo(teamNameLabel.snp.top)
        }
    }
}
