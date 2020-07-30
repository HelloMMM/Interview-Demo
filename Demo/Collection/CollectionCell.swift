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
    var photoModel: Dictionary<String, String> = [:] {
        didSet {
            
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        
        imageView.showAnimatedGradientSkeleton()
    }
    
    func updateUI() {
        
        name.text = photoModel["title"]
        photoUrl = photoModel["photoUrl"]!
        imageView.sd_setImage(with: URL(string: photoUrl)) { (image, error, type, url) in

            self.imageView.hideSkeleton()
        }
    }
    
    @IBAction func collectionClick(_ sender: UIButton) {
        
        collectionLibrary[photoModel["id"]!] = nil
        UserDefaults.standard.set(collectionLibrary, forKey: "collectionLibrary")
        delegate?.reloadData()
    }
}
