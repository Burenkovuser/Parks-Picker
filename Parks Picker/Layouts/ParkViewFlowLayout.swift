//
//  ParkViewFlowLayout.swift
//  Parks Picker
//
//  Created by Vasilii on 22/08/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit

class ParkViewFlowLayout: UICollectionViewFlowLayout {

    var appearingIndexPath: IndexPath?
    var disappiringIndexPaths: [IndexPath]?
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath), let indexPath  = appearingIndexPath, indexPath  == itemIndexPath else {
            return nil
        }
                attributes.alpha = 1.0
        attributes.center = CGPoint(x: collectionView!.frame.width - 24, y: -24)
        attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
        attributes.zIndex = 5
        
        return attributes
    }
    
    // создаем поля у ячейки
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var cashe = [UICollectionViewLayoutAttributes]()
        if let layoutAttributes = super.layoutAttributesForElements(in: rect) {
            for attributte in layoutAttributes {
                let cellAttributes = attributte.copy() as! UICollectionViewLayoutAttributes
                if attributte.representedElementKind == nil {
                    let frame = cellAttributes.frame
                    cellAttributes.frame = frame.insetBy(dx: 2.0, dy: 2.0)
                }
                cashe.append(cellAttributes)
            }
        }
        return cashe
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath), let indexPaths = disappiringIndexPaths, indexPaths.contains(itemIndexPath) else {
            return nil
        }
        attributes.transform = CGAffineTransform(scaleX: 0.1, y: 0.1).rotated(by: -CGFloat.pi / 4)
        return attributes
    }
}

    

