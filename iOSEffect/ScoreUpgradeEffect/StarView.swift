//
//  StarView.swift
//  iOSEffect
//
//  Created by whaley on 2022/1/3.
//

import UIKit

class StarView: UIView {
    
    var isAnimating: Bool = false
    
    var starNum: Int = 0 {
        didSet {
            if starNum > 3 {
                starLowView.isHidden = true
                starHighView.isHidden = false
                starLab.text = "x\(starNum)"
            } else {
                starLowView.isHidden = false
                starHighView.isHidden = true
                
                star0.isHidden = starNum < 1
                star1.isHidden = starNum < 2
                star2.isHidden = starNum < 3
            }
        }
    }
    
    private let StarAnimationKey = "StarAnimation"
    private var targetStar: Int = 0
    
    private var timer: DispatchSourceTimer?
    
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
        starLowView.addSubview(grayStar0)
        starLowView.addSubview(grayStar1)
        starLowView.addSubview(grayStar2)
        starLowView.addSubview(star0)
        starLowView.addSubview(star1)
        starLowView.addSubview(star2)
        
        starContainer.append(star0)
        starContainer.append(star1)
        starContainer.append(star2)
        
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
        
        grayStar0.snp.makeConstraints { make in
            make.edges.equalTo(star0)
        }
        
        grayStar1.snp.makeConstraints { make in
            make.edges.equalTo(star1)
        }
        
        grayStar2.snp.makeConstraints { make in
            make.edges.equalTo(star2)
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
    
    private func createStar(_ isGray: Bool = false) -> UIImageView {
        let star = UIImageView()
        if isGray {
            star.image = UIImage(named: "achievement_level_star")?.converToGrey() ?? UIImage()
        } else {
            star.image = UIImage(named: "achievement_level_star") ?? UIImage()
        }
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
    
    private lazy var starContainer: [UIImageView] = {
        let container = [UIImageView]()
        return container
    }()
    
    private lazy var star0: UIImageView = {
        let star = createStar()
        star.isHidden = true
        return star
    }()
    
    private lazy var star1: UIImageView = {
        let star = createStar()
        star.isHidden = true
        return star
    }()
    
    private lazy var star2: UIImageView = {
        let star = createStar()
        star.isHidden = true
        return star
    }()
    
    private lazy var grayStar0: UIImageView = {
        let star = createStar(true)
        return star
    }()
    
    private lazy var grayStar1: UIImageView = {
        let star = createStar(true)
        return star
    }()
    
    private lazy var grayStar2: UIImageView = {
        let star = createStar(true)
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
    
    // MARK: - Animation
    
    func startAnimation(to index: Int, duration: CFTimeInterval) {
        stopStarAnimation()
        isAnimating = true
        targetStar = index
        
        if index <= starNum {
            return
        }
        
        self.cancelTimer()
        
        if starNum > 3 {
            // 高星级试图切换
            starHighView.layer.add(hideAnimation(tag: 0, duration: duration * 0.5), forKey: StarAnimationKey)
            
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.schedule(deadline: .now() + duration * 0.5)
            timer.setEventHandler { [weak self] in
                guard let self = self else { return }
                self.cancelTimer()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.starNum = self.targetStar
                    self.starHighView.layer.add(self.showAnimation(tag: 1, duration: duration), forKey: self.StarAnimationKey)
                }
            }
            timer.resume()
            self.timer = timer
        } else if index > 3 {
            // 低星级到高星级
            starLowView.layer.add(hideAnimation(tag: 0, duration: duration), forKey: StarAnimationKey)
            
            let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer.schedule(deadline: .now() + duration * 0.5)
            timer.setEventHandler { [weak self] in
                guard let self = self else { return }
                self.cancelTimer()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.starNum = self.targetStar
                    self.starHighView.layer.add(self.showAnimation(tag: 1, duration: duration), forKey: self.StarAnimationKey)
                }
            }
            timer.resume()
            self.timer = timer
        } else {
            // 低星级升级
            let currentNum = starNum
            starNum = index
            for i in currentNum..<index {
                let star = starContainer[i]
                star.layer.add(showAnimation(tag: 1, duration: duration), forKey: StarAnimationKey)
            }
        }
    }
    
    func stopStarAnimation() {
        if !isAnimating {
            return
        }
        isAnimating = false
        
        star0.layer.removeAnimation(forKey: StarAnimationKey)
        star1.layer.removeAnimation(forKey: StarAnimationKey)
        star2.layer.removeAnimation(forKey: StarAnimationKey)
        starLowView.layer.removeAnimation(forKey: StarAnimationKey)
        starHighView.layer.removeAnimation(forKey: StarAnimationKey)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.starNum = self.targetStar
        }
    }
    
    private func hideAnimation(tag: Int, duration: CFTimeInterval) -> CAAnimationGroup {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        animationGroup.duration = duration
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        animationGroup.setValue(tag, forKey: "Tag")
        return animationGroup
    }
    
    private func showAnimation(tag: Int, duration: CFTimeInterval) -> CAAnimationGroup {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        animationGroup.duration = duration
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        animationGroup.setValue(tag, forKey: "Tag")
        return animationGroup
    }
    
    private func cancelTimer() {
        self.timer?.cancel()
        self.timer = nil
    }
}

extension StarView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag,
           let tag = anim.value(forKey: "Tag") as? Int,
           tag == 1 {
           isAnimating = false
        }
    }
}

extension UIImage {
    
    func converToGrey() -> UIImage {
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        let width = self.size.width
        let height = self.size.height
        let colorSpace = CGColorSpaceCreateDeviceGray()
        
        if let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo) {
            if let cgImage = self.cgImage {
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
                
                if let contextCGImage = context.makeImage() {
                    let grayImage = UIImage(cgImage: contextCGImage)
                    return grayImage
                }
            }
        }
        return UIImage()
    }
}
