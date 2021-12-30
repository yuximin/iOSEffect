//
//  UserHomePageTagView.swift
//  buttoneffect
//
//  Created by apple on 2021/12/15.
//

import UIKit

class UserHomePageTagView: UIView {
    
    private var animationDuration = 1.0
    private var effectCount = 2
    
    private lazy var waveView: WaveView = {
        let waveView = WaveView(frame: .zero, spacing: 2)
        return waveView
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 12)
        lab.textAlignment = .center
        lab.text = "Join"
        lab.textColor = .white
        return lab
    }()
    
    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.red.cgColor
        return layer
    }()
    
    private lazy var effectLayers: [CALayer] = {
        var effectLayers = [CALayer]()
        for i in 0..<effectCount {
            let layer = CALayer()
            layer.backgroundColor = UIColor.clear.cgColor
            layer.borderWidth = 1.5
            layer.borderColor = UIColor.red.cgColor
            effectLayers.append(layer)
        }
        return effectLayers
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = bounds.height / 2
        backgroundLayer.frame = bounds
        backgroundLayer.cornerRadius = bounds.height / 2
        backgroundLayer.masksToBounds = true
        
        addEffect()
    }
    
    private func setupViews() {
        for i in 0..<effectCount {
            layer.addSublayer(effectLayers[i])
        }
        layer.addSublayer(backgroundLayer)
        addSubview(waveView)
        addSubview(titleLab)
    }
    
    private func setupConstraints() {
        waveView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(12)
        }
        
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(waveView.snp.right).offset(5)
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalToSuperview().offset(-8)
        }
    }
    
    private func addEffect() {
        for i in 0..<effectCount {
            let layer = effectLayers[i]
            layer.frame = bounds
            layer.cornerRadius = bounds.height / 2
            layer.masksToBounds = true
            layer.removeAnimation(forKey: "Ripple")
            layer.add(rippleAnimation(tag: i, beginTime: Double(i) * (animationDuration / Double(effectCount))), forKey: "Ripple")
        }
    }
    
    private func rippleAnimation(tag: Int, beginTime: CFTimeInterval) -> CAAnimationGroup {
        let offset = 14.0
        
        let boundsAnimation = CABasicAnimation(keyPath: "bounds")
        boundsAnimation.toValue = CGRect(x: -offset, y: -offset, width: bounds.size.width + offset * 2, height: bounds.size.height + offset * 2)
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.toValue = (bounds.size.height + offset * 2) * 0.5
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [1, 0.9, 0.8, 0.5, 0.2]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [boundsAnimation, cornerRadiusAnimation, opacityAnimation]
        animationGroup.beginTime = CACurrentMediaTime() + beginTime
        animationGroup.duration = animationDuration
        animationGroup.repeatCount = .infinity
        animationGroup.isRemovedOnCompletion = false
        animationGroup.timingFunction = CAMediaTimingFunction.init(name: .linear)
        return animationGroup
    }
    
}
