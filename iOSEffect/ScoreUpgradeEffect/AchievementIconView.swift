//
//  AchievementIconView.swift
//  iOSEffect
//
//  Created by apple on 2021/12/31.
//

import UIKit

class AchievementIconView: UIView {
    var rank: Int = 1 {
        didSet {
            let imageName = "achievement_level_small_\(rank)"
            rankImage = UIImage(named: imageName) ?? UIImage()
        }
    }
    
    var level: Int = 1 {
        didSet {
            let imageName = "achievement_level_passage_\(level)"
            levelImage = UIImage(named: imageName) ?? UIImage()
        }
    }
    
    var star: Int = 1 {
        didSet {
            starView.starNum = star
        }
    }
    
    private var timer: DispatchSourceTimer?
    
    private var targetRank: Int = 0
    private var targetLevel: Int = 0
    private var targetStar: Int = 0
    
    private let RankAnimationKey = "RankAnimation"
    private let LevelAnimationKey = "LevelAnimation"
    private let StarAnimationKey = "StarAnimation"
    
    private var rankImage: UIImage = UIImage() {
        didSet {
            rankIcon.image = rankImage
        }
    }
    
    private var levelImage: UIImage = UIImage() {
        didSet {
            levelIcon.image = levelImage
        }
    }
    
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
        addSubview(rankIcon)
        addSubview(levelIcon)
        addSubview(starView)
        
        rankIcon.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(rankIcon.snp.width).multipliedBy(79.0 / 111.0)
            make.edges.equalToSuperview()
        }
        
        levelIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(rankIcon)
            make.height.equalTo(8)
        }
        
        starView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(38)
        }
    }
    
    // MARK: - lazy view
    
    /// 段位
    private lazy var rankIcon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    /// 等级
    private lazy var levelIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// 星级
    private lazy var starView: StarView = {
        let view = StarView()
        return view
    }()
    
    // MARK: - animation
    
    /// 段位提升动画
    func startRankUpgradeAnimation(to rank: Int, duration: CFTimeInterval) {
        targetRank = rank
        self.cancelTimer()
        
        layer.add(rankAnimation(duration: duration), forKey: RankAnimationKey)
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now() + duration * 0.5)
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.cancelTimer()
            DispatchQueue.main.async {
                self.rank = rank
            }
        }
        timer.resume()
        self.timer = timer
    }
    
    func stopRankUpgradeAnimation() {
        self.cancelTimer()
        self.layer.removeAnimation(forKey: RankAnimationKey)
        self.rank = targetRank
    }
    
    /// 等级提升动画
    func startLevelUpgradeAnimation(to level: Int, duration: CFTimeInterval) {
        targetLevel = level
        self.cancelTimer()
        
        levelIcon.layer.add(levelAnimation(duration: duration), forKey: LevelAnimationKey)
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now() + duration * 0.5)
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.cancelTimer()
            DispatchQueue.main.async {
                self.level = level
            }
        }
        timer.resume()
        self.timer = timer
    }
    
    func stopLevelUpgradeAnimation() {
        self.cancelTimer()
        levelIcon.layer.removeAnimation(forKey: LevelAnimationKey)
        self.level = targetLevel
    }
    
    /// 星级提升动画
    func startStarUpgradeAnimation(to star: Int, duration: CFTimeInterval) {
        starView.startAnimation(to: star, duration: duration)
    }
    
    func stopStarUpgradeAnimation() {
        starView.stopStarAnimation()
    }
    
    private func rankAnimation(duration: CFTimeInterval) -> CAAnimationGroup {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [1, 0, 1]
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [1, 0, 1]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        animationGroup.duration = duration
        return animationGroup
    }
    
    private func levelAnimation(duration: CFTimeInterval) -> CAAnimationGroup {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [1, 0, 1]
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [1, 0, 1]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        animationGroup.duration = duration
        return animationGroup
    }
    
    private func cancelTimer() {
        self.timer?.cancel()
        self.timer = nil
    }
}
