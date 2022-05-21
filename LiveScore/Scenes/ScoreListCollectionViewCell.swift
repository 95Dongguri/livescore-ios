//
//  ScoreListCollectionViewCell.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/20.
//

import Kingfisher
import SnapKit
import UIKit


class ScoreListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ScoreListCollectionViewCell"
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .light)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var homeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textColor = .systemRed
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var awayNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var homeScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var awayScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        label.textColor = .label
        
        return label
    }()
    
    func setup(result: Result) {
        setupLayout()
        
        guard let imageURL = URL(string: result.competition.emblem ?? "") else { return }
        
        logoImageView.kf.setImage(with: imageURL)
        
        statusLabel.text = result.status
        homeNameLabel.text = result.homeTeam.name
        awayNameLabel.text = result.awayTeam.name
        
        let homeScore = result.score.fullTime?.homeTeam ?? 0
        let awayScore = result.score.fullTime?.awayTeam ?? 0
        
        if homeScore > awayScore {
            homeScoreLabel.text = "\(homeScore)"
            homeScoreLabel.textColor = .systemRed
            awayScoreLabel.text = "\(awayScore)"
        } else if homeScore < awayScore {
            homeScoreLabel.text = "\(homeScore)"
            awayScoreLabel.text = "\(awayScore)"
            awayScoreLabel.textColor = .systemRed
        } else {
            homeScoreLabel.text = "\(homeScore)"
            awayScoreLabel.text = "\(awayScore)"
        }
        
        
//        let data = try? Data(contentsOf: imageURL)
//        let logo = SVGKImage(data: data)
//
//        logoImageView.image = logo?.uiImage
    }
}

extension ScoreListCollectionViewCell {
    func setupLayout() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        [logoImageView, homeNameLabel, homeScoreLabel, statusLabel, awayNameLabel, awayScoreLabel].forEach {
            addSubview($0)
        }
        
        statusLabel.snp.makeConstraints {
            $0.centerX.equalTo(logoImageView)
            $0.top.equalTo(logoImageView.snp.bottom).offset(3.0)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10.0)
            $0.leading.equalToSuperview().inset(8.0)
            $0.height.equalTo(50.0)
            $0.width.equalTo(50.0)
        }
        
        homeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.0)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(5.0)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.top.equalTo(homeNameLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        awayNameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalTo(homeNameLabel.snp.leading)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.bottom.equalTo(awayNameLabel.snp.bottom)
            $0.trailing.equalTo(homeScoreLabel.snp.trailing)
        }
    }
}
