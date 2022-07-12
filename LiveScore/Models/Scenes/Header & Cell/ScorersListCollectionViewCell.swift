//
//  ScorersListCollectionViewCell.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import Kingfisher
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
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
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
        
        guard let imageURL = URL(string: scores.team.crest ?? "") else { return }
        
        logoImageView.kf.setImage(with: imageURL)
        
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
        
        [logoImageView, nameLabel, birthLabel, nationLabel, positionLabel, teamNameLabel, goalLabel, assistsLabel, penaltiesLabel].forEach {
            addSubview($0)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(80.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(16.0)
        }
        
        birthLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top)
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
            $0.centerX.equalTo(logoImageView)
            $0.top.equalTo(logoImageView.snp.bottom).offset(5.0)
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
