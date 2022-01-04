//
//  ScoreUpgradeEffectViewController.swift
//  buttoneffect
//
//  Created by apple on 2021/12/30.
//

import UIKit

class ScoreUpgradeEffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(upgradeView)
        upgradeView.addSubview(titleLab)
        upgradeView.addSubview(integralLab)
        upgradeView.addSubview(rankView)
        upgradeView.addSubview(progressBar)
        
        view.addSubview(startProgressButton)
        view.addSubview(stopProgressButton)
        view.addSubview(startTitleUpgradeButton)
        view.addSubview(stopTitleUpgradeButton)
        view.addSubview(startIntegralUpgradeButton)
        view.addSubview(stopIntegralUpgradeButton)
        view.addSubview(startRankUpgradeButton)
        view.addSubview(stopRankUpgradeButton)
        view.addSubview(startLevelUpgradeButton)
        view.addSubview(stopLevelUpgradeButton)
        view.addSubview(startStarUpgradeButton)
        view.addSubview(stopStarUpgradeButton)
    }
    
    private func setupConstraints() {
        
        upgradeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(247)
            make.height.equalTo(107.5)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(4)
        }
        
        integralLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(progressBar.snp.top).offset(-5)
        }
        
        rankView.snp.makeConstraints { make in
            make.bottom.equalTo(integralLab.snp.bottom)
            make.left.equalToSuperview().offset(8)
        }
        
        progressBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo(231)
            make.height.equalTo(12)
        }
        
        // Button
        
        startProgressButton.snp.makeConstraints { make in
            make.top.equalTo(upgradeView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        stopProgressButton.snp.makeConstraints { make in
            make.top.equalTo(startProgressButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        startTitleUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(stopProgressButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        stopTitleUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(startTitleUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        startIntegralUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(stopTitleUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        stopIntegralUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(startIntegralUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        startRankUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(stopIntegralUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        stopRankUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(startRankUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        startLevelUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(stopRankUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        stopLevelUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(startLevelUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        startStarUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(stopLevelUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        stopStarUpgradeButton.snp.makeConstraints { make in
            make.top.equalTo(startStarUpgradeButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - lazy view
    
    private lazy var upgradeView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    // MARK: progressBar
    
    private lazy var progressBar: ProgressBar = {
        let bar = ProgressBar()
        bar.floorColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 229.0/255.0, alpha: 0.3)
        bar.barColor = UIColor(red: 155.0/255.0, green: 223.0/255.0, blue: 255.0/255.0, alpha: 1)
        bar.progress = 0.2
        return bar
    }()
    
    private lazy var startProgressButton: UIButton = {
        let btn = UIButton()
        btn.tag = 0
        btn.setTitle("开始进度条", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stopProgressButton: UIButton = {
        let btn = UIButton()
        btn.tag = 1
        btn.setTitle("停止进度条", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: title
    
    private lazy var titleLab: ScoreLabel = {
        let lab = ScoreLabel()
        lab.text = "Music Lover"
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = .boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var startTitleUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 2
        btn.setTitle("开始称号动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stopTitleUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 3
        btn.setTitle("停止称号动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: integral
    
    private lazy var integralLab: ScoreLabel = {
        let lab = ScoreLabel()
        lab.text = "500"
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = .boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var startIntegralUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 4
        btn.setTitle("开始积分动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stopIntegralUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 5
        btn.setTitle("停止积分动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: rank
    
    private lazy var rankView: AchievementIconView = {
        let view = AchievementIconView()
        view.rank = 1
        view.level = 1
        view.star = 0
        return view
    }()
    
    private lazy var startRankUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 6
        btn.setTitle("开始段位升级动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stopRankUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 7
        btn.setTitle("停止段位升级动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var startLevelUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 8
        btn.setTitle("开始等级升级动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stopLevelUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 9
        btn.setTitle("停止等级升级动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var startStarUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 10
        btn.setTitle("开始星级动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stopStarUpgradeButton: UIButton = {
        let btn = UIButton()
        btn.tag = 11
        btn.setTitle("停止星级动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Action
    private var progressGroup = [0.5, 0.8, 0.9, 0.2]
    private var currentIndex = 0
    private var levelTitle = "Music Lover"
    @objc private func onTapButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let progress = progressGroup[currentIndex]
            currentIndex = (currentIndex + 1) % progressGroup.count
            progressBar.startAnimation(to: progress, duration: 2)
        case 1:
            progressBar.stopAnimation()
        case 2:
            if levelTitle == "Music Lover" {
                levelTitle = "Novice Singer"
            } else {
                levelTitle = "Music Lover"
            }
            titleLab.startUpgradeAnimation(to: levelTitle, in: 2)
        case 3:
            titleLab.stopUpgradeAnimation()
        case 4:
            integralLab.startIntegralAnimation(from: 20, to: 500, duration: 2)
        case 5:
            integralLab.stopIntegralAnimation()
        case 6:
            rankView.startRankUpgradeAnimation(to: 3, duration: 2)
        case 7:
            rankView.stopRankUpgradeAnimation()
        case 8:
            rankView.startLevelUpgradeAnimation(to: 4, duration: 2)
        case 9:
            rankView.stopLevelUpgradeAnimation()
        case 10:
            rankView.startStarUpgradeAnimation(to: 3, duration: 2)
        case 11:
            rankView.stopStarUpgradeAnimation()
        default:
            break
        }
    }
}
