//
//  TestViewController.swift
//  iOSEffect
//
//  Created by apple on 2022/1/8.
//

import UIKit

class TestViewController: UIViewController {
    
    private let rowCount = 4 // 每页最大行数
    private let colCount = 2 // 每页最大列数

    private lazy var collectionView: UICollectionView = {
        
        let flowLayout = TestFlowLayout(rowCount: rowCount, colCount: colCount)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TestUICollectionViewCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(100)
        }
        
        view.layoutIfNeeded()
        
        let collectionViewWidth = collectionView.bounds.width
        collectionView.snp.updateConstraints { make in
            make.height.equalTo(collectionViewWidth / CGFloat(rowCount) * CGFloat(colCount))
        }
    }

}

extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestUICollectionViewCell", for: indexPath)
        cell.backgroundColor = .black
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1.0
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let lab = UILabel(frame: cell.bounds)
        lab.text = "\(indexPath.row)"
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 18.0)
        lab.textAlignment = .center
        
        cell.contentView.addSubview(lab)
        return cell
    }
}
