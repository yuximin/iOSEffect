//
//  GiftFlyView.swift
//  iOSEffect
//
//  Created by apple on 2022/1/13.
//

import UIKit

class GiftFlyView: UIView {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
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
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - public
    
    func doFlyAnimation(in view: UIView, from startPoint: CGPoint, to endPoint: CGPoint, offset: CGFloat, duration: CFTimeInterval) {
        view.addSubview(self)
        
        let path = calcGiftPath(from: startPoint, to: endPoint, offset: offset)
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = duration
        animation.path = path
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        layer.add(animation, forKey: "FlyAnimation")
    }
    
    private func calcGiftPath(from startPoint: CGPoint, to endPoint: CGPoint, offset: CGFloat) -> CGPath {
        let x = startPoint.x + (endPoint.x - startPoint.x) / 2
        let y = min(startPoint.y, endPoint.y) + offset
        let controlPoint = CGPoint(x: x, y: y)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        return path.cgPath
    }

}

extension GiftFlyView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        layer.removeAllAnimations()
        removeFromSuperview()
    }
}
