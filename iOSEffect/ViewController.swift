//
//  ViewController.swift
//  buttoneffect
//
//  Created by apple on 2021/12/6.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func rippleEffectAction(_ sender: UIButton) {
        let viewController = RippleEffectViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func waveEffectAction(_ sender: UIButton) {
        let viewController = WaveEffectViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func lightAroundEffect(_ sender: UIButton) {
        let viewController = LightAroundEffectViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func scoreUpgrade(_ sender: UIButton) {
        let viewController = ScoreUpgradeEffectViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

