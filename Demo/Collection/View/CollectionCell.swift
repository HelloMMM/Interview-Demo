//
//  CollectionCell.swift
//  Demo
//
//  Created by HellöM on 2020/7/30.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate {
    func reloadData()
}

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var collectionBtn: UIButton!
    var delegate: CollectionCellDelegate?
    var photoUrl = ""
    var photoModel: PhotoModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        
        imageView.showAnimatedGradientSkeleton()
    }
    
    func updateUI() {
        
        name.text = photoModel?.title
        let id = photoModel!.id
        let secret = photoModel!.secret
        photoUrl = "https://farm1.staticflickr.com/2/\(id)_\(secret)_m.jpg"
        imageView.sd_setImage(with: URL(string: photoUrl)) { (image, error, type, url) in

            self.imageView.hideSkeleton()
        }
    }
    
    @IBAction func collectionClick(_ sender: UIButton) {
        
        let id = "id = '\(photoModel!.id)'"
        CoreDataConnect.shared.delete(predicate: id)
        
        if CoreDataConnect.shared.retrieve(predicate: nil, sort: nil, limit: nil) != nil {
            collectionLibrary = CoreDataConnect.shared.retrieve(predicate: nil, sort: nil, limit: nil)!
        }
        
        delegate?.reloadData()
    }
}
