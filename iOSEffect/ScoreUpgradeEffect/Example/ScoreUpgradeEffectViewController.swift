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
            "积分动画",
            "升星动画低",
            "升星动画低到高",
            "升星动画高",
            "升级动画",
            "升段动画",
            "停止动画"
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
        gradeView.rankInfo = OLGameUserRankModel(isUpgrade: false, integral: 40, rankNumber: 111, rank: 1, level: 1, star: 1, startIntegral: 40, maxIntegral: 200)
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
            gradeView.stopAnimation()
            gradeView.rankInfo = OLGameUserRankModel(isUpgrade: false, integral: 40, rankNumber: 111, rank: 1, level: 1, star: 1, startIntegral: 40, maxIntegral: 200)
            gradeView.starAnimation(to: OLGameUserRankModel(isUpgrade: false, integral: 80, rankNumber: 111, rank: 1, level: 1, star: 1, startIntegral: 40, maxIntegral: 200))
        case 1:
            gradeView.stopAnimation()
            gradeView.rankInfo = OLGameUserRankModel(isUpgrade: false, integral: 40, rankNumber: 111, rank: 1, level: 1, star: 1, startIntegral: 40, maxIntegral: 200)
            gradeView.starAnimation(to: OLGameUserRankModel(isUpgrade: false, integral: 220, rankNumber: 112, rank: 1, level: 1, star: 2, startIntegral: 40, maxIntegral: 400))
        case 2:
            gradeView.stopAnimation()
            gradeView.rankInfo = OLGameUserRankModel(isUpgrade: false, integral: 520, rankNumber: 113, rank: 1, level: 1, star: 3, startIntegral: 520, maxIntegral: 600)
            gradeView.starAnimation(to: OLGameUserRankModel(isUpgrade: false, integral: 630, rankNumber: 114, rank: 1, level: 1, star: 4, startIntegral: 520, maxIntegral: 800))
        case 3:
            gradeView.stopAnimation()
            gradeView.rankInfo = OLGameUserRankModel(isUpgrade: false, integral: 630, rankNumber: 114, rank: 1, level: 1, star: 4, startIntegral: 630, maxIntegral: 800)
            gradeView.starAnimation(to: OLGameUserRankModel(isUpgrade: false, integral: 860, rankNumber: 115, rank: 1, level: 1, star: 5, startIntegral: 630, maxIntegral: 1000))
        case 4:
            gradeView.stopAnimation()
            gradeView.rankInfo = OLGameUserRankModel(isUpgrade: false, integral: 520, rankNumber: 113, rank: 1, level: 1, star: 3, startIntegral: 520, maxIntegral: 600)
            gradeView.starAnimation(to: OLGameUserRankModel(isUpgrade: false, integral: 630, rankNumber: 121, rank: 1, level: 2, star: 1, startIntegral: 520, maxIntegral: 800))
        case 5:
            gradeView.stopAnimation()
            gradeView.rankInfo = OLGameUserRankModel(isUpgrade: false, integral: 520, rankNumber: 113, rank: 1, level: 1, star: 3, startIntegral: 520, maxIntegral: 600)
            gradeView.starAnimation(to: OLGameUserRankModel(isUpgrade: false, integral: 630, rankNumber: 211, rank: 2, level: 1, star: 1, startIntegral: 520, maxIntegral: 800))
        case 6:
            gradeView.stopAnimation()
        default:
            break

        }
    }

}
