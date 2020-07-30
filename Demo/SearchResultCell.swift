//
//  SearchResultCell.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import SkeletonView

class SearchResultCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var collectionBtn: UIButton!
    var isCollection = false
    override func awakeFromNib() {
        
        imageView.showAnimatedGradientSkeleton()
    }
    
    @IBAction func collectionClick(_ sender: UIButton) {
        
        if isCollection {
            collectionBtn.setImage(UIImage(named: "collect"), for: .normal)
        } else {
            collectionBtn.setImage(UIImage(named: "collect-1"), for: .normal)
        }
        isCollection = !isCollection
    }
}
