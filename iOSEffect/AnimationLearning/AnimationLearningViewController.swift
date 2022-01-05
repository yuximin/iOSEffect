//
//  AnimationLearningViewController.swift
//  iOSEffect
//
//  Created by apple on 2022/1/5.
//

import UIKit

class AnimationLearningViewController: UIViewController {
    
    private let titles: [String] = [
        "移除所有动画",
        "缩放动画",
        "旋转动画",
        "平移动画",
        "中心点位置",
        "bounds",
        "不透明度",
        "圆角",
        "边框宽度",
        "背景颜色",
        "阴影颜色",
        "阴影偏移",
        "阴影透明",
        "阴影圆角",
        "UIAnimation平移"
    ]

    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(animatedArea)
        animatedArea.addSubview(animatedView)
        animatedView.addSubview(referenceView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        animatedArea.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        animatedView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        referenceView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(20)
            make.height.equalTo(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(animatedArea.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - lazy
    
    private lazy var animatedArea: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var animatedView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        
        view.layer.cornerRadius = 2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 43, height: 23)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapAnimatedView))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    private lazy var referenceView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - private function
    
    @objc private func onTapAnimatedView() {
        print("Tap AnimationView")
    }
    
    // MARK: - Animation
    
    func startScaleAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "ScaleAnimation")
    }
    
    func startRotationAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = Double.pi / 4
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "RotationAnimation")
    }
    
    func startTranslationAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.translation")
        animation.toValue = CGPoint(x: 50, y: 50)
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "TranslationAnimation")
    }
    
    func startPositionAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.toValue = CGPoint(x: 100, y: 100)
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "PositionAnimation")
    }
    
    func startBoundsAnimation() {
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.toValue = CGRect(x: 10, y: 10, width: 80, height: 40)
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "BoundsAnimation")
    }
    
    func startOpacityAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.values = [1, 0, 1]
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "OpacityAnimation")
    }
    
    func startCornerRadiusAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "cornerRadius")
        animation.values = [2, 10, 2]
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "CornerRadiusAnimation")
    }
    
    func startBorderWidthAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "borderWidth")
        animation.values = [1, 3, 1]
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "BorderWidthAnimation")
    }
    
    func startBackgroundColorAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "backgroundColor")
        animation.values = [UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "BackgroundColorAnimation")
    }
    
    func startShadowColorAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "shadowColor")
        animation.values = [UIColor.white.cgColor, UIColor.black.cgColor, UIColor.white.cgColor]
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "ShadowColorAnimation")
    }
    
    func startShadowOffsetAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "shadowOffset")
        animation.values = [CGSize(width: 43, height: 23), CGSize(width: 46, height: 26), CGSize(width: 43, height: 23)]
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "ShadowOffsetAnimation")
    }
    
    func startShadowOpacityAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "shadowOpacity")
        animation.values = [1, 0, 1]
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "ShadowOpacityAnimation")
    }
    
    func startShadowRadiusAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "shadowRadius")
        animation.values = [2, 10, 2]
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.delegate = self
        
        animatedView.layer.add(animation, forKey: "ShadowRadiusAnimation")
    }
    
    func startTranslationUIViewAnimation() {
        animatedView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 5) {
            self.animatedView.transform = CGAffineTransform(translationX: 100, y: 0)
        } completion: { [weak self] completed in
            guard let self = self else { return }
            print("to:", self.animatedView.frame, self.animatedView.bounds)
//            self.animatedView.transform = CGAffineTransform.identity
        }
    }
    
    func stopAnimation() {
        animatedView.layer.removeAllAnimations()
    }

}

extension AnimationLearningViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell")
        }
        
        
        if let cell = cell {
            if #available(iOS 14.0, *) {
                var configuration = cell.defaultContentConfiguration()
                configuration.text = titles[indexPath.row]
                cell.contentConfiguration = configuration
            } else {
                cell.textLabel?.text = titles[indexPath.row]
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("from:", animatedView.frame, animatedView.bounds)
        switch indexPath.row {
        case 0:
            stopAnimation()
        case 1:
            startScaleAnimation()
        case 2:
            startRotationAnimation()
        case 3:
            startTranslationAnimation()
        case 4:
            startPositionAnimation()
        case 5:
            startBoundsAnimation()
        case 6:
            startOpacityAnimation()
        case 7:
            startCornerRadiusAnimation()
        case 8:
            startBorderWidthAnimation()
        case 9:
            startBackgroundColorAnimation()
        case 10:
            startShadowColorAnimation()
        case 11:
            startShadowOffsetAnimation()
        case 12:
            startShadowOpacityAnimation()
        case 13:
            startShadowRadiusAnimation()
        case 14:
            startTranslationUIViewAnimation()
        default:
            break
        }
    }
}

extension AnimationLearningViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("to:", animatedView.frame, animatedView.bounds)
    }
}
