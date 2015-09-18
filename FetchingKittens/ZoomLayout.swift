//
//  ZoomLayout.swift
//  FetchingKittens
//
//  Created by Pablo Surfate on 9/3/15.
//  Copyright © 2015 Pablo Paciello. All rights reserved.
//

import UIKit

class ZoomLayout: UICollectionViewFlowLayout {
    
    var pinchedCellScale = CGFloat(){
        didSet {
            invalidateLayout()
        }
    }
    
    var pinchedCellCenter = CGPoint() {
        didSet {
            invalidateLayout()
        }
    }
    
    var pinchedCellPath = NSIndexPath?()
    
    override func prepareLayout() {
        itemSize = CGSizeMake(100.0, 100.0)
    }
    
    func applyPinchToLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        if (layoutAttributes.indexPath == pinchedCellPath)
        {
            layoutAttributes.transform3D = CATransform3DMakeScale(pinchedCellScale, pinchedCellScale, 1.0)
            layoutAttributes.center = pinchedCellCenter
            layoutAttributes.zIndex = 1
        }

    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let allAttributesInRect = super.layoutAttributesForElementsInRect(rect)
        
        for cellAttributes in allAttributesInRect! {
            applyPinchToLayoutAttributes(cellAttributes)
        }
        
        return allAttributesInRect
        
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        
        applyPinchToLayoutAttributes(attributes!)
        
        return attributes
    }

}
