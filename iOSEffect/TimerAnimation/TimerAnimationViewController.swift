//
//  TimerAnimationViewController.swift
//  iOSEffect
//
//  Created by apple on 2022/1/7.
//

import UIKit

class TimerAnimationViewController: UIViewController {
    
    private var displayLink: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        view.addSubview(referView)
        view.addSubview(springView)
        view.layer.addSublayer(mainLayer)
        view.addSubview(animatedBtn)
    }
    
    // MARK: - lazy view
    
    private lazy var mainLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.green.cgColor
        return layer
    }()
    
    private lazy var referView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var springView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var animatedBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: (view.bounds.width - 120) / 2, y: view.bounds.height / 2 + 50, width: 120, height: 30))
        btn.setTitle("animated", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapAnimatedBtn(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - private
    
    @objc private func onTapAnimatedBtn(_ sender: UIButton) {
        startAnimation()
    }
    
    private func startAnimation() {
        let target = CGPoint(x: 0, y: view.center.y / 2)
        referView.layer.position = target
        springView.layer.position = target
        
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(animateWave))
        displayLink?.add(to: RunLoop.current, forMode: .common)
        
        let move = CASpringAnimation(keyPath: "position")
        move.fromValue = NSValue(cgPoint: .zero)
        move.toValue = NSValue(cgPoint: target)
        move.duration = 2
        
        let spring = CASpringAnimation(keyPath: "position")
        spring.fromValue = NSValue(cgPoint: .zero)
        spring.toValue = NSValue(cgPoint: target)
        spring.duration = 2
        spring.damping = 7
        spring.delegate = self
        
        referView.layer.add(move, forKey: nil)
        springView.layer.add(spring, forKey: nil)
        referView.layer.position = target
        springView.layer.position = target
    }
    
    @objc private func animateWave() {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: view.frame.width, y: 0))
        
        let controlY = springView.layer.presentation()?.position.y
        let referY = referView.layer.presentation()?.position.y
        
        path.addLine(to: CGPoint(x: view.frame.width, y: referY!))
        path.addQuadCurve(to: CGPoint(x: 0, y: referY!), controlPoint: CGPoint(x: view.frame.width / 2, y: controlY!))
        path.addLine(to: .zero)
        mainLayer.path = path.cgPath
    }

}

extension TimerAnimationViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        displayLink?.invalidate()
        displayLink = nil
    }
}
