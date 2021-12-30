//
//  RippleView.swift
//  buttoneffect
//
//  Created by apple on 2021/12/6.
//

import UIKit
import SnapKit

class RippleView: UIView {
    var image: UIImage = UIImage() {
        didSet {
            button.setImage(image, for: .normal)
        }
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var lineLayer: CAShapeLayer = {
        let lineLayer = CAShapeLayer()
        lineLayer.frame = bounds
        lineLayer.masksToBounds = true
        lineLayer.cornerRadius = bounds.size.height * 0.5
        lineLayer.borderWidth = 1
        lineLayer.borderColor = UIColor(red: 244.0/255.0, green: 0, blue: 160.0/255.0, alpha: 1.0).cgColor
        return lineLayer
    }()
    
    private lazy var rippleLayer: CAShapeLayer = {
        let rippleLayer = CAShapeLayer()
        rippleLayer.frame = bounds
        rippleLayer.masksToBounds = true
        rippleLayer.cornerRadius = bounds.size.height * 0.5
        rippleLayer.borderWidth = 1
        rippleLayer.borderColor = UIColor(red: 244.0/255.0, green: 0, blue: 160.0/255.0, alpha: 1.0).cgColor
        return rippleLayer
    }()
    
    var isAnimationPlaying: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(button)
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
    
    func startAnimation() {
        guard !isAnimationPlaying else {
            return
        }
        
        isAnimationPlaying = true
        
        layer.insertSublayer(lineLayer, at: 0)
        layer.insertSublayer(rippleLayer, at: 0)
        rippleLayer.add(rippleAnimation(), forKey: "ripple_effect")
        button.layer.add(scaleAnimation(), forKey: "button_effect")
    }
    
    func stopAnimation() {
        guard isAnimationPlaying else {
            return
        }
        
        lineLayer.removeFromSuperlayer()
        rippleLayer.removeFromSuperlayer()
        rippleLayer.removeAllAnimations()
        button.layer.removeAllAnimations()
        
        isAnimationPlaying = false
    }
    
    private func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 0.9
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.duration = 0.5
        scaleAnimation.autoreverses = true
        return scaleAnimation
    }
    
    private func rippleAnimation() -> CAAnimationGroup {
        let offset = 7.0
        
        let boundsAnimation = CABasicAnimation(keyPath: "bounds")
        boundsAnimation.toValue = CGRect(x: -offset, y: -offset, width: bounds.size.width + offset * 2, height: bounds.size.height + offset * 2)
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.toValue = (bounds.size.height + offset * 2) * 0.5
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = 0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [boundsAnimation, cornerRadiusAnimation, opacityAnimation]
        animationGroup.duration = 1.0
        animationGroup.repeatCount = .infinity
        return animationGroup
    }
    
}
