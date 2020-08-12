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
        
        if CoreDataConnect.shared.someEntityExists(id: photoModel!.id) {
            
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

            let id = "id = '\(photoModel!.id)'"
            CoreDataConnect.shared.delete(predicate: id)
        } else {
            
            collectionBtn.setImage(UIImage(named: "collect-1"), for: .normal)
            
            let coreData: [String: Any] = ["id": photoModel!.id, "owner": photoModel!.owner,
                                           "secret": photoModel!.secret, "server": photoModel!.server,
                                           "farm": photoModel!.farm, "title": photoModel!.title,
                                           "ispublic": photoModel!.ispublic, "isfriend": photoModel!.isfriend,
                                           "isfamily": photoModel!.isfamily]
            
            CoreDataConnect.shared.insert(attributeInfo: coreData)
            
        }
        
        if CoreDataConnect.shared.retrieve(predicate: nil, sort: nil, limit: nil) != nil {
            collectionLibrary = CoreDataConnect.shared.retrieve(predicate: nil, sort: nil, limit: nil)!
        }
        isCollection = !isCollection
    }
}
