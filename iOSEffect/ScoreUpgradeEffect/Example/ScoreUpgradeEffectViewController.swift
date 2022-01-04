//
//  ScoreUpgradeEffectViewController.swift
//  buttoneffect
//
//  Created by apple on 2021/12/30.
//

import UIKit

class ScoreUpgradeEffectViewController: UIViewController {
    
    lazy var titles: [String] = {
        return [
            "开始动画",
            "停止动画",
            "开始进度条动画",
            "停止进度条动画",
            "开始称号动画",
            "停止称号动画",
            "开始积分动画",
            "停止积分动画",
            "开始段位升级动画",
            "停止段位升级动画",
            "开始等级升级动画",
            "停止等级升级动画",
            "开始星级升级动画",
            "停止星级升级动画"
        ]
    }()
    
    private var progressGroup = [0.5, 0.8, 0.9, 0.2]
    private var currentIndex = 0
    private var levelTitle = "Music Lover"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gradeView.rankInfo = OLGameUserRankModel(isUpgrade: false, integral: 40, rankNumber: 200, rank: 2, level: 3, star: 8, startIntegral: 40, maxIntegral: 200)
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(gradeView)
        view.addSubview(tableView)
        
        gradeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(247)
            make.height.equalTo(107.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(gradeView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - lazy view
    
    private lazy var gradeView: GradeView = {
        let view = GradeView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.estimatedRowHeight = 40
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
}

extension ScoreUpgradeEffectViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableViewCell")
        }
        cell?.textLabel?.text = titles[row]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        switch row {
        case 0:
            gradeView.starAnimation(to: OLGameUserRankModel(isUpgrade: false, integral: 120, rankNumber: 400, rank: 3, level: 1, star: 2, startIntegral: 40, maxIntegral: 400))
        case 1:
            gradeView.stopAnimation()
//        case 2:
//            let progress = progressGroup[currentIndex]
//            currentIndex = (currentIndex + 1) % progressGroup.count
//            progressBar.startAnimation(to: progress, duration: 2)
//        case 3:
//            progressBar.stopAnimation()
//        case 4:
//            if levelTitle == "Music Lover" {
//                levelTitle = "Novice Singer"
//            } else {
//                levelTitle = "Music Lover"
//            }
//            titleLab.startUpgradeAnimation(to: levelTitle, in: 2)
//        case 5:
//            titleLab.stopUpgradeAnimation()
//        case 6:
//            integralLab.startIntegralAnimation(from: 20, to: 500, duration: 2)
//        case 7:
//            integralLab.stopIntegralAnimation()
//        case 8:
//            rankView.startRankUpgradeAnimation(to: 3, duration: 2)
//        case 9:
//            rankView.stopRankUpgradeAnimation()
//        case 10:
//            rankView.startLevelUpgradeAnimation(to: 4, duration: 2)
//        case 11:
//            rankView.stopLevelUpgradeAnimation()
//        case 12:
//            rankView.startStarUpgradeAnimation(to: 2, duration: 2)
//        case 13:
//            rankView.stopStarUpgradeAnimation()
        default:
            break

        }
    }

}
