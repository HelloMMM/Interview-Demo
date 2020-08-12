//
//  CollectionVC.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alertView: UIView!
    let collectionVM = CollectionVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        collectionVM.person.addObserver { (bool) in
            
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        collectionVM.dataProcess()
    }
    
    func initUI() {
        
        let w = UIScreen.main.bounds.width/2-30
        let h = w*1.296
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: w, height: h)
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        
        collectionVM.dataProcess()
    }
}

extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionVM.photoModels.count == 0 {
            alertView.alpha = 1
        } else {
            alertView.alpha = 0
        }
        
        return collectionLibrary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        let photoModel = collectionVM.photoModels[indexPath.row]
        cell.photoModel = photoModel
        cell.delegate = self
        
        return cell
    }
}

extension CollectionVC: CollectionCellDelegate {
    
    func reloadData() {
        collectionVM.dataProcess()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)
    }
}
