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
            rankImage = UIImage(named: "achievement_level_small_1") ?? UIImage()
        }
    }
    
    var level: Int = 1 {
        didSet {
            levelImage = UIImage(named: "achievement_level_passage_1") ?? UIImage()
        }
    }
    
    var star: Int = 1 {
        didSet {
            starView.starNum = star
        }
    }
    
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
            make.height.equalTo(10)
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
        
    }
    
    /// 等级提升动画
    func startLevelUpgradeAnimation(to level: Int, duration: CFTimeInterval) {
        
    }
    
    /// 星级提升动画
    func startStarUpgradeAnimation(to star: Int, duration: CFTimeInterval) {
        
    }
}

class StarView: UIView {
    
    var starNum: Int = 0 {
        didSet {
            if starNum > 3 {
                starLowView.isHidden = true
                starHighView.isHidden = false
                starLab.text = "x\(starNum)"
            } else {
                starLowView.isHidden = false
                starHighView.isHidden = true
            }
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
        addSubview(starBg)
        addSubview(starLowView)
        starLowView.addSubview(star0)
        starLowView.addSubview(star1)
        starLowView.addSubview(star2)
        
        addSubview(starHighView)
        starHighView.addSubview(starHigh)
        starHighView.addSubview(starLab)

        starBg.snp.makeConstraints { make in
            make.width.equalTo(42)
            make.height.equalTo(10)
            make.edges.equalToSuperview()
        }
        
        starLowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        star1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(1)
            make.width.equalTo(7.5)
            make.height.equalTo(7)
        }
        
        star0.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(star1.snp.leading).offset(-3)
            make.width.equalTo(7.5)
            make.height.equalTo(7)
        }

        star2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(star1.snp.trailing).offset(3)
            make.width.equalTo(7.5)
            make.height.equalTo(7)
        }
        
        starHighView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.equalToSuperview()
        }
        
        starHigh.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(7.5)
            make.height.equalTo(7)
        }
        
        starLab.snp.makeConstraints { make in
            make.leading.equalTo(starHigh.snp.trailing).offset(2)
            make.trailing.bottom.equalToSuperview()
        }
    }
    
    private func createStar() -> UIImageView {
        let star = UIImageView()
        star.image = UIImage(named: "achievement_level_star") ?? UIImage()
        return star
    }
    
    // MARK: - lazy
    
    /// 星级底板
    private lazy var starBg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "achievement_level_small_scroll") ?? UIImage()
        return imageView
    }()
    
    private lazy var starLowView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private lazy var star0: UIImageView = {
        let star = createStar()
        return star
    }()
    
    private lazy var star1: UIImageView = {
        let star = createStar()
        return star
    }()
    
    private lazy var star2: UIImageView = {
        let star = createStar()
        return star
    }()
    
    private lazy var starHighView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private lazy var starHigh: UIImageView = {
        let star = createStar()
        return star
    }()
    
    private lazy var starLab: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .white
        lab.font = .boldSystemFont(ofSize: 6)
        lab.textAlignment = .center
        return lab
    }()
    
}
