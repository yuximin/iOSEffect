//
//  ProgressBar.swift
//  buttoneffect
//
//  Created by apple on 2021/12/30.
//

import UIKit

class ProgressBar: UIView {
    
    private let ProgressAnimationKey = "ProgressAnimation"
    
    var isAnimating: Bool = false
    
    var floorColor: UIColor = .white {
        didSet {
            backgroundColor = floorColor
        }
    }
    
    var barColor: UIColor = .green {
        didSet {
            barView.backgroundColor = barColor
        }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            changeToProgress(progress)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame = barView.frame
        frame.size.width = bounds.width * progress
        frame.size.height = bounds.height
        barView.frame = frame
        barView.layer.cornerRadius = bounds.height / 2
        layer.cornerRadius = bounds.height / 2
    }
    
    private func setupUI() {
        backgroundColor = floorColor
        addSubview(barView)
    }
    
    // MARK: - lazy view
    
    private lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor
        return view
    }()
    
    // MARK: - public
    
    func startAnimation(to ratio: CGFloat, duration: CGFloat) {
        isAnimating = true
        barView.layer.add(progressAnimation(ratio, duration: duration), forKey: ProgressAnimationKey)
    }
    
    func stopAnimation() {
        if !isAnimating {
            return
        }
        isAnimating = false
        
        barView.layer.removeAnimation(forKey: ProgressAnimationKey)
    }
    
    // MARK: - private
    
    private func changeToProgress(_ ratio: CGFloat) {
        var frame = barView.frame
        frame.size.width = bounds.width * ratio
        barView.frame = frame
    }
    
    // MARK: - animation
    
    private func progressAnimation(_ ratio: CGFloat, duration: CFTimeInterval) -> CAAnimationGroup {
        let boundsAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        boundsAnimation.toValue = bounds.width * ratio
        
        let positionAnimation = CABasicAnimation(keyPath: "position.x")
        positionAnimation.toValue = bounds.width * ratio * 0.5
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [boundsAnimation, positionAnimation]
        animationGroup.duration = duration
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.setValue(ratio, forKey: "ratio")
        animationGroup.delegate = self
        return animationGroup
    }
    
}

// MARK: - CAAnimationDelegate

extension ProgressBar: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            isAnimating = false
        }
        
        if let ratio = anim.value(forKey: "ratio") as? CGFloat {
            progress = ratio
        }
    }
}
