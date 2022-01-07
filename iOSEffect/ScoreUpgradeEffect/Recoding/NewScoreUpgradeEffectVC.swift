//
//  NewScoreUpgradeEffectVC.swift
//  iOSEffect
//
//  Created by apple on 2022/1/6.
//

import UIKit

class NewScoreUpgradeEffectVC: UIViewController {
    
    private let titles: [String] = [
        "开始称号动画",
        "停止称号动画"
    ]

    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
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
    
    private lazy var gradeView: NewGradeView = {
        let view = NewGradeView()
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

extension NewScoreUpgradeEffectVC: UITableViewDelegate, UITableViewDataSource {
    
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
            gradeView.startTitleAnimation(to: "NewTitle", duration: 2)
        case 1:
            gradeView.stopTitleAnimation()
        default:
            break
        }
    }
}
