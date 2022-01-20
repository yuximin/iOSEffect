//
//  CustomCollectionViewFlowLayout.swift
//  iOSEffect
//
//  Created by apple on 2022/1/19.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        print("prepare")
        super.prepare()
        self.collectionView!.decelerationRate = .fast
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        print("targetContentOffset")
        print(itemSize, self.collectionView!.contentOffset, self.collectionView!.bounds, proposedContentOffset, self.sectionInset, velocity)
        let pageWidth = self.itemSize.width + self.minimumLineSpacing
        let approximatePage = self.collectionView!.contentOffset.x / pageWidth
        let currentPage = velocity.x == 0 ? round(approximatePage) : (velocity.x < 0 ? floor(approximatePage) : ceil(approximatePage))
        let margin = (self.collectionView!.bounds.size.width - self.itemSize.width) * 0.5
        let newHorizontalOffset = self.sectionInset.left + CGFloat(currentPage) * pageWidth - margin
        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
    }

}
