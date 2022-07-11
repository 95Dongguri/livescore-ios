//
//  LiveListCollectionViewCell.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/20.
//

import Kingfisher
import SnapKit
import UIKit
import WebKit


class LiveListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ScoreListCollectionViewCell"
    
    private lazy var logoView: WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        webView.contentMode = .scaleAspectFill
        webView.sizeToFit()
        webView.autoresizesSubviews = true
        
        return webView
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
        
        guard let url = URL(string: result.competition.emblem ?? "") else { return }
        
        DispatchQueue.global(qos: .default).async {
            let logoRequest = URLRequest(url: url)
            DispatchQueue.main.async {
                self.logoView.load(logoRequest)
            }
        }

        statusLabel.text = result.status
        homeNameLabel.text = result.homeTeam.name
        awayNameLabel.text = result.awayTeam.name
        
        let homeScore = result.score.fullTime?.home ?? 0
        let awayScore = result.score.fullTime?.away ?? 0
        
        if homeScore > awayScore {
            homeScoreLabel.text = "\(homeScore)"
            homeScoreLabel.textColor = .systemRed
            awayScoreLabel.text = "\(awayScore)"
            awayScoreLabel.textColor = .label
        } else if homeScore < awayScore {
            homeScoreLabel.text = "\(homeScore)"
            homeScoreLabel.textColor = .label
            awayScoreLabel.text = "\(awayScore)"
            awayScoreLabel.textColor = .systemRed
        } else {
            homeScoreLabel.text = "\(homeScore)"
            awayScoreLabel.text = "\(awayScore)"
            homeScoreLabel.textColor = .label
            awayScoreLabel.textColor = .label
        }
    }
}

extension LiveListCollectionViewCell {
    func setupLayout() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        [logoView, homeNameLabel, homeScoreLabel, statusLabel, awayNameLabel, awayScoreLabel].forEach {
            addSubview($0)
        }
        
        statusLabel.snp.makeConstraints {
            $0.centerX.equalTo(logoView)
            $0.top.equalTo(logoView.snp.bottom).offset(3.0)
        }
        
        logoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10.0)
            $0.leading.equalToSuperview().inset(8.0)
            $0.height.equalTo(50.0)
            $0.width.equalTo(50.0)
        }
        
        homeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.0)
            $0.leading.equalTo(logoView.snp.trailing).offset(5.0)
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
