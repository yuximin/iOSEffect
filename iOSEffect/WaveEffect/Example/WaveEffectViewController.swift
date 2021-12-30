//
//  WaveEffectViewController.swift
//  buttoneffect
//
//  Created by apple on 2021/12/27.
//

import UIKit

class WaveEffectViewController: UIViewController {

    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white        
        setupSubviews()
        setupConstraints()
    }

    // MARK: - UI

    private func setupSubviews() {
        view.addSubview(waveView)
        view.addSubview(rankAvatarTagView)
        view.addSubview(userHomePageTagView)
    }

    private func setupConstraints() {
        waveView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(21)
            make.height.equalTo(20)
        }
        
        rankAvatarTagView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(waveView.snp.bottom).offset(50)
        }
        
        userHomePageTagView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rankAvatarTagView.snp.bottom).offset(50)
        }
    }
    
    // MARK: - lazy
    
    private lazy var waveView: WaveView = {
        let view = WaveView(frame: .zero, color: .black)
        return view
    }()
    
    private lazy var rankAvatarTagView: RankAvatarTagView = {
        let view = RankAvatarTagView(frame: .zero)
        return view
    }()
    
    private lazy var userHomePageTagView: UserHomePageTagView = {
        let view = UserHomePageTagView(frame: .zero)
        return view
    }()
    
}
