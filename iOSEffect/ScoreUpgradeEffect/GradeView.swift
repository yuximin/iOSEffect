//
//  GradeView.swift
//  iOSEffect
//
//  Created by apple on 2022/1/4.
//

import UIKit

class GradeView: UIView {
    
    var isAnimating: Bool {
        titleLab.isAnimating || integralLab.isAnimating || rankView.isAnimating
    }
    
    var rankInfo: OLGameUserRankModel? {
        didSet {
            guard let rankInfo = rankInfo else {
                return
            }
            
            titleLab.text = "Music Lover"
            integralLab.text = "\(rankInfo.integral)"
            maxIntegralLab.text = "/\(rankInfo.maxIntegral)"
            rankView.rank = rankInfo.rank
            rankView.level = rankInfo.level
            rankView.star = rankInfo.star
            progressBar.progress = CGFloat(rankInfo.integral) / CGFloat(rankInfo.maxIntegral)
        }
    }
    
    private var targetRankInfo: OLGameUserRankModel?
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        backgroundColor = .gray
        
        addSubview(titleLab)
        addSubview(integralLab)
        addSubview(maxIntegralLab)
        addSubview(rankView)
        addSubview(progressBar)
        
        titleLab.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(4)
        }
        
        maxIntegralLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(progressBar.snp.top).offset(-5)
        }
        
        integralLab.snp.makeConstraints { make in
            make.trailing.equalTo(maxIntegralLab.snp.leading)
            make.centerY.equalTo(maxIntegralLab)
        }
        
        rankView.snp.makeConstraints { make in
            make.bottom.equalTo(integralLab.snp.bottom)
            make.leading.equalToSuperview().offset(8)
        }
        
        progressBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo(231)
            make.height.equalTo(12)
        }
    }
    
    // MARK: - lazy
    
    private lazy var progressBar: ProgressBar = {
        let bar = ProgressBar()
        bar.floorColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 229.0/255.0, alpha: 0.3)
        bar.barColor = UIColor(red: 155.0/255.0, green: 223.0/255.0, blue: 255.0/255.0, alpha: 1)
        bar.progress = 0.2
        return bar
    }()
    
    private lazy var titleLab: ScoreLabel = {
        let lab = ScoreLabel()
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = .boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var integralLab: ScoreLabel = {
        let lab = ScoreLabel()
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = .boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var maxIntegralLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = .boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var rankView: AchievementIconView = {
        let view = AchievementIconView()
        return view
    }()
    
    // MARK: - Animation
    
    func starAnimation(to info: OLGameUserRankModel) {
        targetRankInfo = info
        
        guard let rankInfo = rankInfo else {
            return
        }
        
        if info.rank > rankInfo.rank {
            titleLab.startUpgradeAnimation(to: "HAHAHAHA", duration: 2)
        }
        rankView.startAnimation(from: rankInfo, to: info, duration: 2)
        maxIntegralLab.text = "/\(info.maxIntegral)"
        integralLab.startIntegralAnimation(from: rankInfo.integral, to: info.integral, duration: 2)
        progressBar.startAnimation(to: CGFloat(info.integral) / CGFloat(info.maxIntegral), duration: 2)
    }
    
    func stopAnimation() {
        guard isAnimating else { return }
        
        titleLab.stopUpgradeAnimation()
        rankView.stopAnimation()
        integralLab.stopIntegralAnimation()
        progressBar.stopAnimation()
    }
}

struct OLGameUserRankModel {
    let isUpgrade: Bool
    let integral: Int
    let rankNumber: Int
    let rank: Int
    let level: Int
    let star: Int
    let startIntegral: Int
    let maxIntegral: Int
}
