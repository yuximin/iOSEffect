//
//  GiftDynamicEffectPlayerView.swift
//  ohla
//
//  Created by apple on 2022/1/17.
//

import UIKit
import BDAlphaPlayer

class GiftDynamicEffectPlayerView: UIView {
    
    // 礼物特效播放队列
    var giftQueue: [String] = []
    
    private var isPlaying: Bool = false
    
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
        addSubview(dbAlphaPlayerView)
    }
    
    // MARK: - lazy view
    
    private lazy var dbAlphaPlayerView: BDAlphaPlayerMetalView = {
        let dbAlphaPlayerView = BDAlphaPlayerMetalView(delegate: self)
        return dbAlphaPlayerView
    }()
    
    // MARK: - animation
    
    func play(with path: String) {
        
        if isPlaying {
            giftQueue.append(path)
            return
        }
        isPlaying = true
        
        doPlay(with: path)
    }
    
    private func doPlay(with path: String) {
        guard let resourcePath = Bundle.main.resourcePath else {
            fatalError("Bundle.main.resourcePath not found")
        }
        
        let config = BDAlphaPlayerMetalConfiguration.default()
        config.directory = "\(resourcePath)/\(path)"
        if bounds.isEmpty {
            setNeedsLayout()
            layoutIfNeeded()
        }
        config.renderSuperViewFrame = bounds
        config.orientation = .portrait
        dbAlphaPlayerView.play(with: config)
    }
    
    private func handleNextPlay() {
        if giftQueue.isEmpty {
            isPlaying = false
            return
        }
        
        let path = giftQueue.removeFirst()
        doPlay(with: path)
    }
    
    func stop() {
        guard isPlaying else { return }
        isPlaying = false
        dbAlphaPlayerView.stop()
        giftQueue.removeAll()
    }
    
    func stopCurrentPlay() {
        guard isPlaying else { return }
        dbAlphaPlayerView.stopWithFinishPlayingCallback()
    }
}

extension GiftDynamicEffectPlayerView: BDAlphaPlayerMetalViewDelegate {
    func metalView(_ metalView: BDAlphaPlayerMetalView, didFinishPlayingWithError error: Error) {
        handleNextPlay()
    }
}
