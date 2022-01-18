//
//  GiftPushContent.swift
//  iOSEffect
//
//  Created by apple on 2022/1/12.
//

import UIKit

class GiftPushContent: UIView {
    
    private var maxCount: Int = 3
    
    /// 礼物弹窗视图
    lazy var giftViews: [GiftPushView] = {
        let gifts = [GiftPushView]()
        return gifts
    }()
    
    /// 礼物数据
    lazy var cacheModels: [GiftModel] = {
        let models = [GiftModel]()
        return models
    }()
    
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
        for idx in 0..<maxCount {
            let giftPushView = createGiftPushView()
            giftPushView.isHidden = true
            addSubview(giftPushView)
            self.giftViews.append(giftPushView)
            
            if idx == 0 {
                giftPushView.snp.makeConstraints { make in
                    make.leading.equalToSuperview()
                    make.top.equalToSuperview().offset(8)
                }
                continue
            }
            
            let previousView = giftViews[idx - 1]
            if idx == maxCount - 1 {
                giftPushView.snp.makeConstraints { make in
                    make.leading.equalToSuperview()
                    make.top.equalTo(previousView.snp.bottom).offset(15)
                    make.bottom.equalToSuperview().offset(-8)
                }
            } else {
                giftPushView.snp.makeConstraints { make in
                    make.leading.equalToSuperview()
                    make.top.equalTo(previousView.snp.bottom).offset(15)
                }
            }
        }
    }
    
    private func createGiftPushView() -> GiftPushView {
        let giftPushView = GiftPushView()
        return giftPushView
    }
    
    // MARK: - public
    
    func presentGiftPush(with model: GiftModel) {
        // 是否正在展示
        if giftPushIsShowing(with: model) {
            return
        }
        
        // 获取展示位置
        guard let giftPushView = (giftViews.first { $0.status == .idle }) else {
            cacheModel(model)
            return
        }
        
        giftPushView.model = model
        giftPushView.updateUI(with: model)
        giftPushView.showPushView { [weak self] in
            self?.handleNextPush()
        }
    }
    
    // MARK: - private
    
    private func giftPushIsShowing(with model: GiftModel) -> Bool {
        guard let giftView = (giftViews.first { $0.status == .showing && $0.model?.tag == model.tag }) else {
            return false
        }
        
        giftView.model?.number += model.number
        giftView.showCombo()
        return true
    }
    
    private func cacheModel(_ model: GiftModel) {
        if let idx = (cacheModels.firstIndex { $0.tag == model.tag }) {
            var cacheModel = cacheModels[idx]
            cacheModel.number += model.number
            cacheModels[idx] = cacheModel
        } else {
            cacheModels.append(model)
        }
    }
    
    private func handleNextPush() {
        if let model = cacheModels.first {
            cacheModels.removeFirst()
            presentGiftPush(with: model)
        }
    }
}
