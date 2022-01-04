//
//  ScoreLabel.swift
//  iOSEffect
//
//  Created by apple on 2021/12/30.
//

import UIKit

class ScoreLabel: UILabel {
    
    var isAnimating: Bool = false
    
    private let UpgradeAnimationKey = "UpgradeAnimation"
    private var targetText: String = ""
    private var tempIntegral: Int = 0
    
    private var timer: DispatchSourceTimer?
    
    // MARK: 段位提升动画
    
    func startUpgradeAnimation(to title: String, duration: CFTimeInterval) {
        isAnimating = true
        targetText = title
        self.cancelTimer()
        
        layer.add(upgradeAnimation(duration: duration), forKey: UpgradeAnimationKey)
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now() + duration * 0.5)
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.cancelTimer()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.text = self.targetText
            }
        }
        timer.resume()
        self.timer = timer
    }
    
    func stopUpgradeAnimation() {
        if !isAnimating {
            return
        }
        isAnimating = false
        
        self.cancelTimer()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.text = self.targetText
            self.layer.removeAnimation(forKey: self.UpgradeAnimationKey)
        }
    }
    
    // MARK: 积分动画(数字)
    
    func startIntegralAnimation(from initialValue: Int, to targetValue: Int, duration: Double) {
        isAnimating = true
        targetText = String(targetValue)
        self.cancelTimer()
        
        var tempIntegral = initialValue
        let interval = Int(duration / Double(targetValue - initialValue) * 1000)
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .milliseconds(interval))
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            
            if self.timer == nil {
                return
            }
            
            tempIntegral += 1
            if tempIntegral > targetValue {
                self.cancelTimer()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.text = self.targetText
                    self.isAnimating = false
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.text = String(tempIntegral)
                }
            }
        }
        timer.resume()
        self.timer = timer
    }
    
    func stopIntegralAnimation() {
        if !isAnimating {
            return
        }
        isAnimating = false
        
        self.cancelTimer()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.text = self.targetText
        }
    }
    
    // MARK: private
    
    private func cancelTimer() {
        self.timer?.cancel()
        self.timer = nil
    }
    
    private func upgradeAnimation(duration: CFTimeInterval) -> CAAnimationGroup {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [1, 0, 1]
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [1, 0, 1]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        animationGroup.duration = duration
        animationGroup.delegate = self
        return animationGroup
    }
}

extension ScoreLabel: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            isAnimating = false
        }
    }
}
