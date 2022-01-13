//
//  GiftPushView.swift
//  iOSEffect
//
//  Created by apple on 2022/1/12.
//

import UIKit

enum GiftPushStatus: Int {
    
    /// 展示中
    case showing = 0
    
    /// 闲置
    case idle
}

class GiftPushView: UIView {
    
    // 展示状态
    var status: GiftPushStatus = .idle
    
    // 是否正在连击
    private var isComboing = false
    
    // 当前展示连击数
    private var comboNum: Int = 0 {
        didSet {
            if comboNum <= 1 {
                numberLab.isHidden = true
            } else {
                numberLab.isHidden = false
            }
            numberLab.text = "x\(comboNum)"
        }
    }
    
    var model: GiftModel?
    
    private var hideCompletionCallback: (() -> Void)?
    
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
        setupSubviews()
        setupConstraints()
    }
    
    /// 添加视图
    private func setupSubviews() {
        addSubview(bgView)
        addSubview(numberLab)
        
        bgView.addSubview(headerImageView)
        bgView.addSubview(giftImageView)
        bgView.addSubview(labelContainer)
        
        labelContainer.addSubview(userNameLab)
        labelContainer.addSubview(sentLab)
        labelContainer.addSubview(toUserNameLab)
    }
    
    /// 设置约束
    private func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.greaterThanOrEqualTo(175)
            make.width.lessThanOrEqualTo(220)
            make.height.equalTo(44)
        }
        
        numberLab.snp.makeConstraints { make in
            make.leading.equalTo(bgView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        headerImageView.snp.makeConstraints { make in
            make.height.width.equalTo(36)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
        }
        
        giftImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(54)
        }
        
        labelContainer.snp.makeConstraints { make in
            make.leading.equalTo(headerImageView.snp.trailing).offset(5)
            make.trailing.equalTo(giftImageView.snp.leading).offset(-5)
            make.centerY.equalToSuperview()
        }

        userNameLab.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        sentLab.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(userNameLab.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        toUserNameLab.snp.makeConstraints { make in
            make.leading.equalTo(sentLab.snp.trailing).offset(3)
            make.top.equalTo(sentLab)
            make.bottom.equalTo(sentLab)
            make.trailing.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.gradientSize(bgView.bounds.size)
            .gradientColors([UIColor(red: 0.58, green: 0.32, blue: 0.84, alpha: 1), UIColor(red: 1, green: 0.32, blue: 0.32, alpha: 0)])
            .gradientLocations([0, 1])
            .gradientStart(CGPoint(x: 0, y: 0.5))
            .gradientEnd(CGPoint(x: 1, y: 0.5))
        bgView.gradientFetchLayer().cornerRadius = bgView.bounds.height / 2
    }
    
    func updateUI(with model: GiftModel) {
        headerImageView.image = UIImage(named: model.headerUrl) ?? UIImage()
        userNameLab.text = model.userName
        toUserNameLab.text = model.toUserName
        giftImageView.image = UIImage(named: model.giftImageUrl) ?? UIImage()
    }
    
    // MARK: - lazy view
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var labelContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var userNameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = .boldSystemFont(ofSize: 14)
        lab.textAlignment = .left
        return lab
    }()
    
    private lazy var sentLab: UILabel = {
        let lab = UILabel()
        lab.text = "Sent"
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 12)
        lab.textAlignment = .left
        lab.alpha = 0.7
        lab.setContentHuggingPriority(.defaultHigh, for: .horizontal) // 抗拉伸
        return lab
    }()
    
    lazy var toUserNameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = .boldSystemFont(ofSize: 12)
        lab.textAlignment = .left
        return lab
    }()
    
    lazy var giftImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var numberLab: GradientLabel = {
        let lab = GradientLabel()
        lab.font = UIFont(name: "Helvetica-BoldOblique", size: 30)
        lab.textAlignment = .left
        lab.colors = [UIColor(red: 255.0/255.0, green: 222.0/255.0, blue: 78.0/255.0, alpha: 1.0), UIColor(red: 255.0/255.0, green: 167.0/255.0, blue: 13.0/255.0, alpha: 1.0)]
        return lab
    }()
    
    // MARK: - animation
    
    func showCombo() {        
        if isComboing {
            return
        }
        
        doCombo()
    }
    
    private func doCombo() {
        if let model = model, model.number > comboNum {
            resetHideTimer()
            isComboing = true
            comboNum += 1
            numberLab.showAnimation { [weak self] in
                guard let self = self else { return }
                self.doCombo()
            }
        } else {
            isComboing = false
        }
    }
    
    func showPushView(_ completion: (() -> Void)? = nil) {
        status = .showing
        self.alpha = 0
        self.transform = CGAffineTransform(translationX: -self.bounds.width - 10, y: 0)
        self.isHidden = false
        
        self.hideCompletionCallback = completion
        
        comboNum = 0
        if let model = model, model.number > 1 {
            numberLab.isHidden = false
            showCombo()
        }
        
        resetHideTimer()
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }
    }
    
    func hidePushView() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
            self.transform = CGAffineTransform(translationX: -self.bounds.width - 10, y: 0)
        } completion: { _ in
            self.isHidden = true
            self.status = .idle
            self.hideCompletionCallback?()
        }
    }
    
    private func resetHideTimer() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(doHideView), with: nil, afterDelay: 5)
    }
    
    @objc private func doHideView() {
        hidePushView()
    }
}
