//
//  UICollectionViewCell+Dequeue.swift
//  Goalv8
//
//  Created by Joachim Kret on 24/09/15.
//  Copyright © 2015 Perform. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    class var identifier: String {
        return NSStringFromClass(self)
    }
    
    class var nibName: String? {
        return nil
    }
    
    static func registerCell(collectionView : UICollectionView) {
        if let cellNibName = nibName {
            let nib = UINib(nibName: cellNibName, bundle: NSBundle.mainBundle())
            collectionView.registerNib(nib, forCellWithReuseIdentifier: identifier)
        } else {
            collectionView.registerClass(self, forCellWithReuseIdentifier: identifier)
        }
    }
    
    static func cell(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
    }
}
