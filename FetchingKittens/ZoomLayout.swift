//
//  ZoomLayout.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/3/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class ZoomLayout: UICollectionViewFlowLayout {
    
    var pinchedCellScale = CGFloat(){ didSet { invalidateLayout() } }
    var pinchedCellCenter = CGPoint() { didSet { invalidateLayout() } }
    var pinchedCellPath: IndexPath?
    
    override func prepare() {
        
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        //We indicate that there are going to be 3 Cells per row.
        let dimension = round((collectionView!.bounds.width - 2) / 3)
        itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func applyPinchToLayoutAttributes(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        
        if (layoutAttributes.indexPath == pinchedCellPath) {
            layoutAttributes.transform3D = CATransform3DMakeScale(pinchedCellScale, pinchedCellScale, 1.0)
            layoutAttributes.center = pinchedCellCenter
            layoutAttributes.zIndex = 1
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let allAttributesInRect = super.layoutAttributesForElements(in: rect)
        
        for cellAttributes in allAttributesInRect! {
            applyPinchToLayoutAttributes(cellAttributes)
        }
        
        return allAttributesInRect
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = super.layoutAttributesForItem(at: indexPath)
        applyPinchToLayoutAttributes(attributes!)
        return attributes
    }
}
