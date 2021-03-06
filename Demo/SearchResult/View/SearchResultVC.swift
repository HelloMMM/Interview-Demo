//
//  SearchResultVC.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

class SearchResultVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alertView: UIView!
    var collectionFooterView: CollectionFooterView?
    let searchResultVM = SearchResultVM()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "搜尋結果 \(searchResultVM.homeModel?.tags ?? "")"
        
        initUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
        
        searchResultVM.person.addObserver { (bool) in
            
            if bool {
                
                self.refreshControl.endRefreshing()
                self.collectionFooterView?.activityIndicatorView.stopAnimating()
                self.searchResultVM.isLoading = false
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.alertView.alpha = 1
            }
        }
    }
    
    func initUI() {
        
        let w = UIScreen.main.bounds.width/2-30
        let h = w*1.296
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: w, height: h)
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(postAPI), for: .valueChanged)
        collectionView.addSubview(refreshControl)

        let collectionFooterView = UINib(nibName: "CollectionFooterView", bundle: nil)
        collectionView.register(collectionFooterView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionFooterView")
        
        postAPI()
    }
    
    @objc func postAPI() {
        
        searchResultVM.page = 1
        searchResultVM.postAPI()
    }
    
    @objc func reloadData() {
        
        collectionView.reloadData()
    }
}

extension SearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if searchResultVM.photoData.count != 0 {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionFooterView", for: indexPath) as! CollectionFooterView
            collectionFooterView = footerView
            collectionFooterView?.backgroundColor = UIColor.clear
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            
            if searchResultVM.photoData.count != 0 {
                collectionFooterView?.activityIndicatorView.startAnimating()
                searchResultVM.nextLoadAPI()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchResultVM.photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
        let photoModel = searchResultVM.photoData[indexPath.row]
        cell.photoModel = photoModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let pohotModel = searchResultVM.photoData[indexPath.row]
        
        let alert = UIAlertController(title: "", message: pohotModel.title, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
//
//            loadAPI()
//        }
//    }
}
