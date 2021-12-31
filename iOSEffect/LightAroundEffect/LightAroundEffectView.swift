//
//  LightAroundEffectView.swift
//  buttoneffect
//
//  Created by apple on 2021/12/28.
//

import UIKit

class LightAroundEffectView: UIView {
    
    weak var target: UIView?
    
    var isAnimating: Bool = false
    private var horizontalAnimationFlag = true
    private var verticalAnimationFlag = true
    
    private let maskCornerRadius: CGFloat = 17.0
    
    private var targetWidth: CGFloat {
        if let target = target {
            return target.bounds.width
        }
        return 0
    }
    
    private var targetHeight: CGFloat {
        if let target = target {
            return target.bounds.height
        }
        return 0
    }
    
    private lazy var lightImage: UIImage = {
        guard let image = UIImage(named: "light_around") else { return UIImage() }
        return image
    }()
    
    private var speed: Double {
        return (lightImage.size.width + targetWidth) / durationHorizontal
    }
    
    var durationHorizontal = 5.0
    private var durationVertical: CGFloat {
        return (lightImage.size.width + targetHeight) / speed
    }
    
    // 横向动画开始延时
    var horizontalDelayTime: TimeInterval {
        return (targetHeight - maskCornerRadius * 4) / speed
    }
    
    // 纵向动画开始延时
    var verticalDelayTime: TimeInterval {
        return (targetWidth - maskCornerRadius * 4) / speed
    }
    
    // MARK: - init
    
    init(frame: CGRect, target: UIView) {
        self.target = target
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
        
        layer.mask = maskLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        maskLayer.frame = bounds
    }
    
    // MARK: - UI
    
    private func setupSubviews() {
        addSubview(lightViewTop)
        addSubview(lightViewRight)
        addSubview(lightViewBottom)
        addSubview(lightViewLeft)
        addSubview(lightViewTop1)
        addSubview(lightViewRight1)
        addSubview(lightViewBottom1)
        addSubview(lightViewLeft1)
    }
    
    private func setupConstraints() {
        lightViewTop.snp.makeConstraints { make in
            make.centerY.equalTo(snp.top)
            make.trailing.equalTo(snp.leading)
        }
        
        lightViewRight.snp.makeConstraints { make in
            make.centerX.equalTo(snp.trailing)
            make.bottom.equalTo(snp.top)
        }
        
        lightViewBottom.snp.makeConstraints { make in
            make.centerY.equalTo(snp.bottom)
            make.leading.equalTo(snp.trailing)
        }
        
        lightViewLeft.snp.makeConstraints { make in
            make.centerX.equalTo(snp.leading)
            make.top.equalTo(snp.bottom)
        }
        
        lightViewTop1.snp.makeConstraints { make in
            make.centerY.equalTo(snp.top)
            make.trailing.equalTo(snp.leading)
        }
        
        lightViewRight1.snp.makeConstraints { make in
            make.centerX.equalTo(snp.trailing)
            make.bottom.equalTo(snp.top)
        }
        
        lightViewBottom1.snp.makeConstraints { make in
            make.centerY.equalTo(snp.bottom)
            make.leading.equalTo(snp.trailing)
        }
        
        lightViewLeft1.snp.makeConstraints { make in
            make.centerX.equalTo(snp.leading)
            make.top.equalTo(snp.bottom)
        }
    }
    
    // MARK: - public
    
    func startLightAnimation() {
        if isAnimating {
            return
        }
        isAnimating = true
        startHorizontalLightAnimation()
    }
    
    func stopLightAnimation() {
        guard isAnimating else {
            return
        }
        isAnimating = false
    }
    
    // MARK: - private
    
    private func startHorizontalLightAnimation() {
        guard isAnimating else { return }
        
        var viewTop: UIImageView
        var viewBottom: UIImageView
        
        if horizontalAnimationFlag {
            viewTop = lightViewTop
            viewBottom = lightViewBottom
        } else {
            viewTop = lightViewTop1
            viewBottom = lightViewBottom1
        }
        horizontalAnimationFlag = !horizontalAnimationFlag
        
        viewTop.transform = CGAffineTransform.identity
        viewBottom.transform = CGAffineTransform.identity
        UIView.animate(withDuration: durationHorizontal) { [weak self] in
            guard let self = self else { return }
            viewTop.transform = CGAffineTransform(translationX: viewTop.bounds.width + self.targetWidth, y: 0)
            viewBottom.transform = CGAffineTransform(translationX: -(viewBottom.bounds.width + self.targetWidth), y: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + verticalDelayTime) { [weak self] in
            self?.startVerticalLightAnimation()
        }
    }
    
    private func startVerticalLightAnimation() {
        guard isAnimating else { return }
        
        var viewRight: UIImageView
        var viewLeft: UIImageView
        
        if verticalAnimationFlag {
            viewRight = lightViewRight
            viewLeft = lightViewLeft
        } else {
            viewRight = lightViewRight1
            viewLeft = lightViewLeft1
        }
        verticalAnimationFlag = !verticalAnimationFlag
        
        viewRight.transform = CGAffineTransform.identity
        viewLeft.transform = CGAffineTransform.identity
        UIView.animate(withDuration: durationVertical) { [weak self] in
            guard let self = self else { return }
            viewRight.transform = CGAffineTransform(translationX: 0, y: viewRight.bounds.height + self.targetHeight)
            viewLeft.transform = CGAffineTransform(translationX: 0, y: -(viewLeft.bounds.height + self.targetHeight))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + horizontalDelayTime) { [weak self] in
            self?.startHorizontalLightAnimation()
        }
    }
    
    // MARK: - lazy
    
    private lazy var lightViewTop: UIImageView = {
        let imageView = UIImageView(image: lightImage)
        return imageView
    }()
    
    private lazy var lightViewRight: UIImageView = {
        let image = UIImage(cgImage: lightImage.cgImage!, scale: lightImage.scale, orientation: .right)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var lightViewBottom: UIImageView = {
        let image = UIImage(cgImage: lightImage.cgImage!, scale: lightImage.scale, orientation: .down)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var lightViewLeft: UIImageView = {
        let image = UIImage(cgImage: lightImage.cgImage!, scale: lightImage.scale, orientation: .left)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var lightViewTop1: UIImageView = {
        let imageView = UIImageView(image: lightImage)
        return imageView
    }()
    
    private lazy var lightViewRight1: UIImageView = {
        let image = UIImage(cgImage: lightImage.cgImage!, scale: lightImage.scale, orientation: .right)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var lightViewBottom1: UIImageView = {
        let image = UIImage(cgImage: lightImage.cgImage!, scale: lightImage.scale, orientation: .down)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var lightViewLeft1: UIImageView = {
        let image = UIImage(cgImage: lightImage.cgImage!, scale: lightImage.scale, orientation: .left)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var maskLayer: CALayer = {
        let layer = CALayer()
        layer.cornerRadius = maskCornerRadius
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()

}
