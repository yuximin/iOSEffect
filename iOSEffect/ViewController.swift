//
//  ViewController.swift
//  buttoneffect
//
//  Created by apple on 2021/12/6.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let titles: [String] = [
        "按钮呼吸动效",
        "波纹扩散动效",
        "光环围绕动效",
        "积分栏动画",
        "重写积分栏动画",
        "动画学习",
        "定时器动画"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableViewCell")
        }
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        switch row {
        case 0:
            let viewController = RippleEffectViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = WaveEffectViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = LightAroundEffectViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = ScoreUpgradeEffectViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 4:
            let viewController = NewScoreUpgradeEffectVC()
            navigationController?.pushViewController(viewController, animated: true)
        case 5:
            let viewController = AnimationLearningViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 6:
            let viewController = TimerAnimationViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
    
    
}
