//
//  AchievementIconView.swift
//  iOSEffect
//
//  Created by apple on 2021/12/31.
//

import UIKit

class AchievementIconView: UIView {
    
    var isAnimating: Bool {
        isRankAnimating || isLevelAnimating || starView.isAnimating
    }
    
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
    
    private var isRankAnimating: Bool = false
    private var isLevelAnimating: Bool = false
    
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
    
    func startAnimation(from originInfo: OLGameUserRankModel, to targetInfo: OLGameUserRankModel, duration: CFTimeInterval) {
        targetRank = targetInfo.rank
        targetLevel = targetInfo.level
        targetStar = targetInfo.star
        
        if originInfo.rank < targetInfo.rank {
            startRankUpgradeAnimation(to: targetInfo.rank, duration: 2)
        } else if originInfo.level < targetInfo.level {
            startLevelUpgradeAnimation(to: targetInfo.level, duration: 2)
            startStarUpgradeAnimation(to: targetInfo.star, duration: 2)
        } else if originInfo.star < targetInfo.star {
            startStarUpgradeAnimation(to: targetInfo.star, duration: 2)
        }
    }
    
    func stopAnimation() {
        guard isAnimating else { return }
        
        stopRankUpgradeAnimation()
        stopLevelUpgradeAnimation()
        stopStarUpgradeAnimation()
        
        rank = targetRank
        level = targetLevel
        star = targetStar
    }
    
    /// 段位提升动画
    private func startRankUpgradeAnimation(to rank: Int, duration: CFTimeInterval) {
        isRankAnimating = true
        targetRank = rank
        self.cancelTimer()
        
        layer.add(rankAnimation(duration: duration), forKey: RankAnimationKey)
        
        let imageName = "achievement_level_small_\(targetRank)"
        let image = UIImage(named: imageName) ?? UIImage()
        let contentsAnimation = CABasicAnimation(keyPath: "contents")
        contentsAnimation.toValue = image.cgImage
        contentsAnimation.duration = duration
        contentsAnimation.fillMode = .forwards
        contentsAnimation.isRemovedOnCompletion = false
        rankIcon.layer.add(contentsAnimation, forKey: RankAnimationKey)
        
//        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
//        timer.schedule(deadline: .now() + duration * 0.5)
//        timer.setEventHandler { [weak self] in
//            guard let self = self else { return }
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                self.rank = self.targetRank
//                self.level = self.targetLevel
//                self.star = self.targetStar
//            }
//        }
//        timer.resume()
//        self.timer = timer
    }
    
    private func stopRankUpgradeAnimation() {
        if !isRankAnimating {
            return
        }
        isRankAnimating = false
        
        self.cancelTimer()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.removeAnimation(forKey: self.RankAnimationKey)
            self.rank = self.targetRank
        }
    }
    
    /// 等级提升动画
    private func startLevelUpgradeAnimation(to level: Int, duration: CFTimeInterval) {
        isLevelAnimating = true
        targetLevel = level
        self.cancelTimer()
        
        levelIcon.layer.add(levelAnimation(duration: duration), forKey: LevelAnimationKey)
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now() + duration * 0.5)
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.level = self.targetLevel
            }
        }
        timer.resume()
        self.timer = timer
    }
    
    private func stopLevelUpgradeAnimation() {
        if !isLevelAnimating {
            return
        }
        isLevelAnimating = false
        
        self.cancelTimer()
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.level = self.targetLevel
            self.levelIcon.layer.removeAnimation(forKey: self.LevelAnimationKey)
        }
    }
    
    /// 星级提升动画
    private func startStarUpgradeAnimation(to star: Int, duration: CFTimeInterval) {
        starView.startAnimation(to: star, duration: duration)
    }
    
    private func stopStarUpgradeAnimation() {
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
        animationGroup.setValue(1, forKey: "Tag")
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
        animationGroup.setValue(2, forKey: "Tag")
        return animationGroup
    }
    
    private func cancelTimer() {
        self.timer?.cancel()
        self.timer = nil
    }
}

extension AchievementIconView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard flag, let tag = anim.value(forKey: "Tag") as? Int else {
            return
        }
        
        if tag == 1 {
            isRankAnimating = false
        } else if tag == 2 {
            isLevelAnimating = false
        }
    }
}
