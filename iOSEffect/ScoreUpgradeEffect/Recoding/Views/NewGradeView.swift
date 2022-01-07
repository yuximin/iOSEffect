//
//  NewGradeView.swift
//  iOSEffect
//
//  Created by apple on 2022/1/6.
//

import UIKit

class NewGradeView: UIView {
    
    private let AnimationName = "AnimationNameKey"
    
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
//        addSubview(integralLab)
//        addSubview(maxIntegralLab)
//        addSubview(rankView)
        addSubview(progressBar)
        
        titleLab.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(4)
        }
        
//        maxIntegralLab.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(-8)
//            make.bottom.equalTo(progressBar.snp.top).offset(-5)
//        }
//
//        integralLab.snp.makeConstraints { make in
//            make.trailing.equalTo(maxIntegralLab.snp.leading)
//            make.centerY.equalTo(maxIntegralLab)
//        }
//
//        rankView.snp.makeConstraints { make in
//            make.bottom.equalTo(integralLab.snp.bottom)
//            make.leading.equalToSuperview().offset(8)
//        }
        
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
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "Title"
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = .boldSystemFont(ofSize: 16)
        return lab
    }()
    
    // MARK: - public
    
    func startTitleAnimation(to title: String, duration: CFTimeInterval) {
//        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
//        scaleAnimation.toValue = 0
//        scaleAnimation.duration = duration / 2
//        scaleAnimation.delegate = self
//        scaleAnimation.setValue("titleFirst", forKey: AnimationName)
//        scaleAnimation.setValue(title, forKey: "title")
//
//        let scaleAnimation1 = CABasicAnimation(keyPath: "transform.scale")
//        scaleAnimation1.toValue = 1
//        scaleAnimation1.beginTime = CACurrentMediaTime() + duration / 2
//        scaleAnimation1.duration = duration / 2
//        scaleAnimation1.delegate = self
//        scaleAnimation1.setValue("titleSecond", forKey: AnimationName)
//
//        let animationGroup = CAAnimationGroup()
//        animationGroup.animations = [scaleAnimation, scaleAnimation1]
//        animationGroup.duration = duration
//
//        titleLab.layer.add(animationGroup, forKey: "TitleAnimationKey")
//        titleLab.layer.add(scaleAnimation1, forKey: "TitleAnimationKey")
        
        UIView.transition(with: titleLab, duration: duration, options: .transitionFlipFromRight) {
            self.titleLab.text = title
        } completion: { _ in

        }
    }
    
    func stopTitleAnimation() {
        self.titleLab.layer.removeAllAnimations()
    }

}

extension NewGradeView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop")
        if let name = anim.value(forKey: AnimationName) as? String {
            if name == "titleFirst", let title = anim.value(forKey: "title") as? String {
                titleLab.text = title
                print("animationDidStop 111")
            }
        }
    }
}
