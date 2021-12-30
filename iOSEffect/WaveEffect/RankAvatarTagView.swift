//
//  RankAvatarTagView.swift
//  buttoneffect
//
//  Created by apple on 2021/12/15.
//

import UIKit
import SnapKit

class RankAvatarTagView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ranking_winner_first_tag")
        return imageView
    }()
    
    private lazy var waveView: WaveView = {
        let waveView = WaveView(frame: .zero, spacing: 2)
        return waveView
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 12)
        lab.textAlignment = .center
        lab.text = "Join"
        lab.textColor = .white
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(waveView)
        addSubview(titleLab)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        waveView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(waveView.snp.right).offset(5)
            make.centerY.height.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
        }
    }
}
