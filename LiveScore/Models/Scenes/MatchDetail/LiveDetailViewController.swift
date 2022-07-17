//
//  LiveDetailViewController.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/07/12.
//

import UIKit
import SDWebImageSVGCoder
import SnapKit

class LiveDetailViewController: UIViewController {
    
    private var presenter: LiveDetailPresenter!
    
    private lazy var leagueNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .medium)

        return label
    }()
    
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
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32.0, weight: .bold)

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
        
        [
            leagueNameLabel,
            homeImageView,
            awayImageView,
            homeNameLabel,
            awayNameLabel,
            homeScoreLabel,
            awayScoreLabel,
            resultLabel
        ].forEach {
            view.addSubview($0)
        }
        
        leagueNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8.0)
            $0.centerX.equalToSuperview()
        }
        
        homeImageView.snp.makeConstraints {
            $0.top.equalTo(leagueNameLabel.snp.bottom).offset(24.0)
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
        
        resultLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(homeScoreLabel.snp.bottom).offset(48.0)
        }
        
        leagueNameLabel.text = result.competition.name
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        guard let homeUrl = URL(string: result.homeTeam.crest ?? "") else { return }
        guard let awayUrl = URL(string: result.awayTeam.crest ?? "") else { return }
        
        DispatchQueue.main.async {
            self.homeImageView.sd_setImage(with: homeUrl)
            self.awayImageView.sd_setImage(with: awayUrl)
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
        
        if result.status == "FINISHED" {
            if homeScore > awayScore {
                resultLabel.textColor = .systemRed
                resultLabel.text = "HOMETEAM WIN!!"
            } else if homeScore < awayScore {
                resultLabel.textColor = .systemBlue
                resultLabel.text = "AWAYTEAM WIN!!"
            } else {
                resultLabel.textColor = .label
                resultLabel.text = "DRAW.."
            }
        } else {
            resultLabel.textColor = .tertiaryLabel
            resultLabel.text = "Not Finished.."
        }
    }
}
