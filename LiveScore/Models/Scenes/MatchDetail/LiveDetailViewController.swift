//
//  LiveDetailViewController.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/07/12.
//

import Kingfisher
import UIKit
import SnapKit
import SVGKit

class LiveDetailViewController: UIViewController {
    
    private var presenter: LiveDetailPresenter!
    
    private lazy var homeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private lazy var awayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private lazy var homeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var awayNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var homeScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48.0, weight: .bold)
        
        return label
    }()
    
    private lazy var awayScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48.0, weight: .bold)
        
        return label
    }()
    
    init(result: Result) {
        super.init(nibName: nil, bundle: nil)
        
        presenter = LiveDetailPresenter(vc: self, result: result)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension LiveDetailViewController: LiveDetailProtocol {
    func setupViews(with result: Result) {
        view.backgroundColor = .systemBackground
        
        [homeImageView, awayImageView, homeNameLabel, awayNameLabel, homeScoreLabel, awayScoreLabel].forEach {
            view.addSubview($0)
        }
        
        homeImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32.0)
            $0.leading.equalToSuperview().inset(48.0)
            $0.width.height.equalTo(120.0)
        }
        
        awayImageView.snp.makeConstraints {
            $0.top.equalTo(homeImageView.snp.top)
            $0.trailing.equalToSuperview().inset(48)
            $0.width.height.equalTo(120.0)
        }
        
        homeNameLabel.snp.makeConstraints {
            $0.top.equalTo(homeImageView.snp.bottom).offset(32.0)
            $0.centerX.equalTo(homeImageView)
        }
        
        awayNameLabel.snp.makeConstraints {
            $0.top.equalTo(awayImageView.snp.bottom).offset(32.0)
            $0.centerX.equalTo(awayImageView)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.top.equalTo(homeNameLabel.snp.bottom).offset(64.0)
            $0.centerX.equalTo(homeImageView)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.top.equalTo(awayNameLabel.snp.bottom).offset(64.0)
            $0.centerX.equalTo(awayImageView)
        }
        
        DispatchQueue.global(qos: .default).async {
            guard let homeCrest = result.homeTeam.crest else { return }
            guard let awayCrest = result.awayTeam.crest  else { return }
            
            if homeCrest.contains("svg") {
                guard let homeUrl = URL(string: homeCrest) else { return }
                
                let homeData = try? Data(contentsOf: homeUrl)
                let homeLogo = SVGKImage(data: homeData)
                
                DispatchQueue.main.async {
                    self.homeImageView.image = homeLogo?.uiImage
                }
            } else {
                guard let homeUrl = URL(string: homeCrest) else { return }
                
                DispatchQueue.main.async {
                    self.homeImageView.kf.setImage(with: homeUrl)
                }
            }
            
            if awayCrest.contains("svg") {
                guard let awayUrl = URL(string: awayCrest) else { return }
                
                let awayData = try? Data(contentsOf: awayUrl)
                let awayLogo = SVGKImage(data: awayData)
                
                DispatchQueue.main.async {
                    self.awayImageView.image = awayLogo?.uiImage
                }
            } else {
                guard let awayUrl = URL(string: awayCrest) else { return }
                
                DispatchQueue.main.async {
                    self.awayImageView.kf.setImage(with: awayUrl)
                }
            }
        }
        
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
