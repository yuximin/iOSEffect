//
//  TestFlowLayout.swift
//  iOSEffect
//
//  Created by apple on 2022/1/8.
//

import UIKit

class TestFlowLayout: UICollectionViewFlowLayout {
    
    private var rowCountPrePage: Int // 每页列数
    private var colCountPrePage: Int // 每页行数
    
    private var cellAttributesArray = [UICollectionViewLayoutAttributes]()
    
    init(rowCount: Int, colCount: Int) {
        self.rowCountPrePage = rowCount
        self.colCountPrePage = colCount
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        let cellWidth = UIScreen.main.bounds.width / CGFloat(rowCountPrePage)
        let cellHeight = cellWidth
        itemSize = CGSize(width: cellWidth, height: cellHeight)
        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0
        scrollDirection = .horizontal
        
        cellAttributesArray.removeAll()
        guard let cellCount = self.collectionView?.numberOfItems(inSection: 0) else {
            return
        }
        
        for i in 0..<cellCount {
            let indexPath = IndexPath(item: i, section: 0)
            if let attributes = self.layoutAttributesForItem(at: indexPath) {
                let page = i / (rowCountPrePage * colCountPrePage) // 第几页
                let row = i % rowCountPrePage + page * rowCountPrePage // 第几列
                let col = i / rowCountPrePage - page * colCountPrePage // 第几行
                attributes.frame = CGRect(x: CGFloat(row) * cellWidth, y: CGFloat(col) * cellHeight, width: cellWidth, height: cellHeight)
                cellAttributesArray.append(attributes)
            } else {
                continue
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cellAttributesArray
    }
    
    override var collectionViewContentSize: CGSize {
        let count = self.collectionView!.numberOfItems(inSection: 0)
        let maxCountPrePage = rowCountPrePage * colCountPrePage
        let rem = count % maxCountPrePage
        let quo = count / maxCountPrePage
        var page = quo
        if rem > 0 {
            page += 1
        }
        return CGSize(width: CGFloat(page) * UIScreen.main.bounds.width, height: 0)
    }

}
