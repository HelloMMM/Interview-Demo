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
    
    override func awakeFromNib() {
        
        imageView.showAnimatedGradientSkeleton()
    }
}
