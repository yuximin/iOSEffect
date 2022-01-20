//
//  CustomCollectionViewController.swift
//  iOSEffect
//
//  Created by apple on 2022/1/19.
//

import UIKit

class CustomCollectionViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = CustomCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.8, height: 50)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width * 0.1, bottom: 0, right: UIScreen.main.bounds.width * 0.1)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.center.width.equalToSuperview()
            make.height.equalTo(100)
        }
    }

}

extension CustomCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.backgroundColor = .gray
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        
        let lab = UILabel(frame: cell.contentView.bounds)
        lab.text = "\(indexPath.item)"
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 18)
        lab.textAlignment = .center
        cell.contentView.addSubview(lab)
        
        return cell
    }
}
