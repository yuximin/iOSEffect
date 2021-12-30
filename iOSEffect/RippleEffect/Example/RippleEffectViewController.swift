//
//  RippleEffectViewController.swift
//  buttoneffect
//
//  Created by apple on 2021/12/27.
//

import UIKit

class RippleEffectViewController: UIViewController {

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
        view.addSubview(rippleView)
    }
    
    private func setupConstraints() {
        rippleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - lazy
    
    private lazy var rippleView: RippleView = {
        let view = RippleView()
        if let image = UIImage(named: "gameroom_button_ready") {
            view.image = image
        }
        view.addTarget(self, action: #selector(onTapRippleView(_:)), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Action
    
    @objc private func onTapRippleView(_ sender: UIButton) {
        guard let view = sender.superview as? RippleView else { return }
        if view.isAnimationPlaying {
            view.stopAnimation()
        } else {
            view.startAnimation()
        }
    }

}
