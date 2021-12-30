//
//  WaveView.swift
//  buttoneffect
//
//  Created by apple on 2021/12/15.
//

import UIKit

class WaveView: UIView {
    private var count: Int = 3
    private var spacing: CGFloat = 3
    
    var color: UIColor = .white {
        didSet {
            updateColor()
        }
    }
    
    var isAutoAnimation: Bool = true
    
    private var itemWidth: CGFloat {
        get {
            if count <= 0 {
                return 0
            }
            
            return (bounds.width - (spacing * (CGFloat(count) - 1))) / CGFloat(count)
        }
    }
    
    private var isAnimated: Bool = false
    
    private var waveLayers: [CALayer]?
    
    init(frame: CGRect, count: Int = 3, spacing: CGFloat = 3, color: UIColor = .white, isAutoAnimation: Bool = true) {
        self.count = count
        self.spacing = spacing
        self.color = color
        self.isAutoAnimation = isAutoAnimation
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        updateWaveLayers()
    }
    
    private func updateWaveLayers() {
        if let layers = waveLayers {
            for subLayer in layers {
                subLayer.removeFromSuperlayer()
            }
        }
        
        var layers = [CALayer]()
        
        var tempX: CGFloat = 0
        for _ in 0..<count {
            let layer = CALayer()
            layer.frame = CGRect(x: tempX, y: 0, width: itemWidth, height: bounds.height)
            layer.backgroundColor = color.cgColor
            layer.cornerRadius = itemWidth * 0.5
            layer.masksToBounds = true
            self.layer.addSublayer(layer)
            layers.append(layer)
            tempX += itemWidth + spacing
        }
        waveLayers = layers
        
        if isAutoAnimation {
            startAnimation()
        }
    }
    
    private func updateColor() {
        guard let layers = waveLayers else {
            return
        }
        
        for subLayer in layers {
            subLayer.backgroundColor = color.cgColor
        }
    }
    
    func startAnimation() {
        if isAnimated {
            return
        }
        isAnimated = true
        
        guard let layers = waveLayers else {
            return
        }
        
        for (idx, subLayer) in layers.enumerated() {
            subLayer.add(self.waveAnimation(to: subLayer, beginTime: CACurrentMediaTime() + CGFloat(idx) * 0.2), forKey: "Wave")
        }
    }
    
    func stopAnimation() {
        guard isAnimated else {
            return
        }
        isAnimated = false
        
        guard let layers = waveLayers else {
            return
        }
        
        for subLayer in layers {
            subLayer.removeAnimation(forKey: "Wave")
        }
    }
    
    func waveAnimation(to layer: CALayer, beginTime: CFTimeInterval) -> CAAnimationGroup {
        let toHeightRatio = 0.2
        
        let boundsAnimation = CABasicAnimation(keyPath: "bounds")
        let bounds = layer.bounds
        boundsAnimation.toValue = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height * toHeightRatio)
        
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.toValue = bounds.height * (1 - toHeightRatio * 0.5)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [boundsAnimation, positionAnimation]
        animationGroup.beginTime = beginTime
        animationGroup.duration = 0.35
        animationGroup.repeatCount = .infinity
        animationGroup.isRemovedOnCompletion = false
        animationGroup.autoreverses = true
        return animationGroup
    }
    
}
