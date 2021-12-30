//
//  ScoreUpgradeEffectViewController.swift
//  buttoneffect
//
//  Created by apple on 2021/12/30.
//

import UIKit

class ScoreUpgradeEffectViewController: UIViewController {

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
        view.addSubview(upgradeView)
        upgradeView.addSubview(titleLab)
        upgradeView.addSubview(progressBar)
        
        view.addSubview(beginProgressButton)
        view.addSubview(stopProgressButton)
    }
    
    private func setupConstraints() {
        
        upgradeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(247)
            make.height.equalTo(107.5)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(4)
        }
        
        progressBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo(231)
            make.height.equalTo(12)
        }
        
        beginProgressButton.snp.makeConstraints { make in
            make.top.equalTo(upgradeView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        
        stopProgressButton.snp.makeConstraints { make in
            make.top.equalTo(beginProgressButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - lazy view
    
    private lazy var upgradeView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    // MARK: progressBar
    
    private lazy var progressBar: ProgressBar = {
        let bar = ProgressBar()
        bar.floorColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 229.0/255.0, alpha: 0.3)
        bar.barColor = UIColor(red: 155.0/255.0, green: 223.0/255.0, blue: 255.0/255.0, alpha: 1)
        bar.progress = 0.2
        print("set progress")
        return bar
    }()
    
    private lazy var beginProgressButton: UIButton = {
        let btn = UIButton()
        btn.tag = 0
        btn.setTitle("开始进度条", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stopProgressButton: UIButton = {
        let btn = UIButton()
        btn.tag = 1
        btn.setTitle("停止进度条", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: text animation
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "Music Lover"
        lab.textColor = .white
        lab.textAlignment = .center
        lab.font = .boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var titleLabButton: UIButton = {
        let btn = UIButton()
        btn.tag = 2
        btn.setTitle("段位名称升级动画", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Action
    private var progressGroup = [0.5, 0.8, 0.9, 0.2]
    private var currentIndex = 0
    @objc private func onTapButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let progress = progressGroup[currentIndex]
            currentIndex = (currentIndex + 1) % progressGroup.count
            progressBar.startAnimation(to: progress, duration: 5)
        case 1:
            progressBar.stopAnimation()
        case 2:
            break
        default:
            break
        }
    }
}

extension UIView {
    func startUpgradeAnimation() {
        
    }
}
