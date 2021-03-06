//
//  GiftViewController.swift
//  iOSEffect
//
//  Created by apple on 2022/1/12.
//

import UIKit

class GiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(giftPushContainer)
        giftPushContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(240)
        }
        
        view.addSubview(sendGift0)
        view.addSubview(sendGift1)
        view.addSubview(sendGift2)
        view.addSubview(sendGift3)
        view.addSubview(moveBtn)
        
        view.addSubview(header0)
        view.addSubview(header1)
        view.addSubview(header2)
        view.addSubview(giftDynamicEffectPlayerView)
        
        sendGift3.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(80)
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        sendGift2.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-80)
            make.bottom.equalTo(sendGift3)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        sendGift1.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(80)
            make.bottom.equalTo(sendGift3.snp.top).offset(-10)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        sendGift0.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-80)
            make.bottom.equalTo(sendGift1)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        moveBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(sendGift0.snp.top).offset(-10)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        header0.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(400)
            make.leading.equalToSuperview().offset(100)
            make.width.height.equalTo(30)
        }
        
        header1.snp.makeConstraints { make in
            make.top.equalTo(header0)//.offset(15)
            make.leading.equalTo(header0.snp.trailing).offset(5)
            make.width.height.equalTo(30)
        }
        
        header2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }
        
        giftDynamicEffectPlayerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - lazy view
    
    private lazy var giftPushContainer: GiftPushContent = {
        let view = GiftPushContent()
        return view
    }()
    
    private lazy var sendGift0: UIButton = {
        let btn = UIButton()
        btn.tag = 0
        btn.setTitle("????????????0", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var sendGift1: UIButton = {
        let btn = UIButton()
        btn.tag = 1
        btn.setTitle("????????????1", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var sendGift2: UIButton = {
        let btn = UIButton()
        btn.tag = 2
        btn.setTitle("????????????2", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var sendGift3: UIButton = {
        let btn = UIButton()
        btn.tag = 3
        btn.setTitle("????????????3", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var moveBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("????????????", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapMoveButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var header0: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon1") ?? UIImage()
        return imageView
    }()
    
    private lazy var header1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon1") ?? UIImage()
        return imageView
    }()
    
    private lazy var header2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon1") ?? UIImage()
        return imageView
    }()
    
    private lazy var giftDynamicEffectPlayerView: GiftDynamicEffectPlayerView = {
        let view = GiftDynamicEffectPlayerView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    // MARK: - Action
    
    @objc private func onTapButton(_ sender: UIButton) {
        let tag = sender.tag
        let model = GiftModel(tag: tag, headerUrl: "icon1", userName: "Andre Mack", toUserName: "Jack", giftImageUrl: "????????????", number: 1)
        giftPushContainer.presentGiftPush(with: model)
        
        var startPoint: CGPoint
        var endPoint: CGPoint
        var offset: CGFloat
        var duration: CFTimeInterval
        switch tag {
        case 0:
            startPoint = header0.center
            endPoint = header1.center
            offset = -100
            duration = 1.0
            giftDynamicEffectPlayerView.play(with: "??????_OHLA")
        case 1:
            startPoint = header1.center
            endPoint = header0.center
            offset = -100
            duration = 1.0
            giftDynamicEffectPlayerView.play(with: "yinyu")
        case 2:
            startPoint = header0.center
            endPoint = header2.center
            offset = 0
            duration = 2.0
            giftDynamicEffectPlayerView.play(with: "??????_OHLA")
        default:
            startPoint = header0.center
            endPoint = header1.center
            offset = -100
            duration = 1.0
            giftDynamicEffectPlayerView.stopCurrentPlay()
        }
        
        let image = UIImage(named: "????????????") ?? UIImage()
        let giftFlyView = GiftFlyView()
        giftFlyView.image = image
        giftFlyView.frame.size = CGSize(width: 20, height: 20 * image.size.height / image.size.width)
        giftFlyView.center = startPoint
        giftFlyView.doFlyAnimation(in: view, from: startPoint, to: endPoint, offset: offset, duration: duration)
    }
    
    @objc private func onTapMoveButton(_ sender: UIButton) {
        giftPushContainer.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(300)
        }
    }
}
