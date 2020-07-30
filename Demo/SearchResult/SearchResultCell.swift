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
    var photoUrl: String = "" 
    var isCollection = false
    var photoModel: PhotoModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        
        imageView.showAnimatedGradientSkeleton()
    }
    
    func updateUI() {
        
        name.text = photoModel!.title
        
        let id = photoModel!.id
        let secret = photoModel!.secret
        photoUrl = "https://farm1.staticflickr.com/2/\(id)_\(secret)_m.jpg"
        imageView.sd_setImage(with: URL(string: photoUrl)) { (image, error, type, url) in

            self.imageView.hideSkeleton()
        }
        
        if collectionLibrary[photoModel!.id] != nil {
            
            isCollection = true
            collectionBtn.setImage(UIImage(named: "collect-1"), for: .normal)
        } else {
            
            isCollection = false
            collectionBtn.setImage(UIImage(named: "collect"), for: .normal)
        }
    }
    
    @IBAction func collectionClick(_ sender: UIButton) {
        
        if isCollection {
            collectionBtn.setImage(UIImage(named: "collect"), for: .normal)
            collectionLibrary[photoModel!.id] = nil
        } else {
            collectionBtn.setImage(UIImage(named: "collect-1"), for: .normal)
            collectionLibrary[photoModel!.id] = ["photoUrl": photoUrl,
                                                 "title": photoModel!.title,
                                                 "id": photoModel!.id]
        }
        isCollection = !isCollection
        UserDefaults.standard.set(collectionLibrary, forKey: "collectionLibrary")
    }
}
