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
        }
        
        view.addSubview(sendGift0)
        view.addSubview(sendGift1)
        view.addSubview(sendGift2)
        view.addSubview(sendGift3)
        view.addSubview(moveBtn)
        
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
            make.bottom.equalTo(sendGift0.snp.top).offset(-10)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    // MARK: - lazy view
    
    private lazy var giftPushContainer: GiftPushContainer = {
        let view = GiftPushContainer()
        return view
    }()
    
    private lazy var sendGift0: UIButton = {
        let btn = UIButton()
        btn.tag = 0
        btn.setTitle("发送礼物0", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var sendGift1: UIButton = {
        let btn = UIButton()
        btn.tag = 1
        btn.setTitle("发送礼物1", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var sendGift2: UIButton = {
        let btn = UIButton()
        btn.tag = 2
        btn.setTitle("发送礼物2", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var sendGift3: UIButton = {
        let btn = UIButton()
        btn.tag = 3
        btn.setTitle("发送礼物3", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var moveBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("位置变动", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(onTapMoveButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Action
    
    @objc private func onTapButton(_ sender: UIButton) {
        let tag = sender.tag
        let model = GiftModel(tag: tag, headerUrl: "icon1", userName: "Andre Mack", toUserName: "Jack", giftImageUrl: "爱心礼物", number: 1)
        giftPushContainer.presentGiftPush(with: model)
    }
    
    @objc private func onTapMoveButton(_ sender: UIButton) {
        giftPushContainer.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(300)
        }
    }

}
