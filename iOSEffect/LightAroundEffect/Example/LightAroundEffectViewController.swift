//
//  LightAroundEffectViewController.swift
//  buttoneffect
//
//  Created by apple on 2021/12/27.
//

import UIKit

class LightAroundEffectViewController: UIViewController {
    
    weak var lightAroundEffectView: LightAroundEffectView?

    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - UI
    
    private func setupSubviews() {
        view.addSubview(targetView)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(navigationButton)
    }

    private func setupConstraints() {
        targetView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(targetView.snp.bottom).offset(50)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        stopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(startButton)
            make.top.equalTo(startButton.snp.bottom).offset(20)
        }
        
        navigationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(startButton)
            make.top.equalTo(stopButton.snp.bottom).offset(20)
        }
    }
    
    // MARK: - lazy
    
    private lazy var targetView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "hits_bg") ?? nil)
        return imageView
    }()
    
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .gray
        btn.setTitle("开始动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapStartBtn(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stopButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .gray
        btn.setTitle("结束动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapStopBtn(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var navigationButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .gray
        btn.setTitle("跳转", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapNavigationBtn(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - action
    
    @objc private func onTapStartBtn(_ sender: UIButton) {
        if let lightAroundEffectView = lightAroundEffectView, lightAroundEffectView.isAnimating {
            return
        }

        let lightAroundEffectView = LightAroundEffectView(frame: targetView.bounds, target: targetView)
        targetView.addSubview(lightAroundEffectView)
        lightAroundEffectView.startLightAnimation()
        self.lightAroundEffectView = lightAroundEffectView
    }
    
    @objc private func onTapStopBtn(_ sender: UIButton) {
        guard let lightAroundEffectView = lightAroundEffectView, lightAroundEffectView.isAnimating else {
            return
        }

        lightAroundEffectView.removeFromSuperview()
        self.lightAroundEffectView = nil
    }
    
    @objc private func onTapNavigationBtn(_ sender: UIButton) {
        let viewController = RippleEffectViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

}
