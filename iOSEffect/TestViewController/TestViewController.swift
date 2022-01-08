//
//  TestViewController.swift
//  iOSEffect
//
//  Created by apple on 2022/1/8.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let rowCount = 4
        let colCount = 2
        let flowLayout = TestFlowLayout(rowCount: rowCount, colCount: colCount)
        
        collectionViewHeight.constant = UIScreen.main.bounds.width / CGFloat(rowCount) * CGFloat(colCount)
        
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TestUICollectionViewCell")
    }

}

extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
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
