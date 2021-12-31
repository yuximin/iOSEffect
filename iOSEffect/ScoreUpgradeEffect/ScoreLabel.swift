//
//  ScoreLabel.swift
//  iOSEffect
//
//  Created by apple on 2021/12/30.
//

import UIKit

class ScoreLabel: UILabel {
    
    private let UpgradeAnimationKey = "UpgradeAnimation"
    private var targetText: String = ""
    private var tempIntegral: Int = 0
    
    private var timer: DispatchSourceTimer?
    
    // MARK: 段位提升动画
    
    func startUpgradeAnimation(to title: String, in duration: CFTimeInterval) {
        targetText = title
        self.cancelTimer()
        
        layer.add(upgradeAnimation(duration: duration), forKey: UpgradeAnimationKey)
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now() + duration * 0.5)
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.cancelTimer()
            DispatchQueue.main.async {
                self.text = self.targetText
            }
        }
        timer.resume()
        self.timer = timer
    }
    
    func stopUpgradeAnimation() {
        self.cancelTimer()
        self.text = targetText
        layer.removeAnimation(forKey: UpgradeAnimationKey)
    }
    
    // MARK: 积分动画(数字)
    
    func startIntegralAnimation(from initialValue: Int, to targetValue: Int, duration: Double) {
        targetText = String(targetValue)
        self.cancelTimer()
        
        var tempIntegral = initialValue
        let interval = Int(duration / Double(targetValue - initialValue) * 1000)
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .milliseconds(interval))
        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            
            tempIntegral += 1
            if tempIntegral > targetValue {
                self.cancelTimer()
                DispatchQueue.main.async {
                    self.text = self.targetText
                }
            } else {
                DispatchQueue.main.async {
                    self.text = String(tempIntegral)
                }
            }
        }
        timer.resume()
        self.timer = timer
    }
    
    func stopIntegralAnimation() {
        self.cancelTimer()
        self.text = targetText
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
        return animationGroup
    }
}
