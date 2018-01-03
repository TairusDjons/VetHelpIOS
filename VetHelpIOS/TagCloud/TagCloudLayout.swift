//
//  TagCloudLayout.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 11.12.17.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import Foundation
import UIKit
class FlowLayout: UICollectionViewFlowLayout {

    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
        // use a value to keep track of left margin
        
        var leftMargin: CGFloat = 4.0;
        
        for attributes in attributesForElementsInRect! {
            // assign value if next row
            if (attributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            } else {
                // set x position of attributes to current margin
                var newLeftAlignedFrame = attributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                attributes.frame = newLeftAlignedFrame
            }
            // calculate new value for current margin
            leftMargin += attributes.frame.size.width + 8
            newAttributesForElementsInRect.append(attributes)
        }
        return newAttributesForElementsInRect
    }
}

