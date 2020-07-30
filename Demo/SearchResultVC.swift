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
import DGElasticPullToRefresh

class SearchResultVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionFooterView: CollectionFooterView?
    let searchResultVM = SearchResultVM()
    var searchResultModel: SearchResultModel?
    var searchData: Dictionary<String, Any> = [:]
    var photoData: [PhotoModel] = [] 
    var isLoading = false
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "搜尋結果 \(searchData["tags"] as! String)"
        
        initUI()
        
        searchResultVM.person.addObserver { (photo: [PhotoModel]) in

            self.collectionView.dg_stopLoading()
            self.isLoading = false
            self.photoData.append(contentsOf: photo)
            self.collectionFooterView?.activityIndicatorView.stopAnimating()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        collectionView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            self?.page = 1
            self?.searchData["page"] = self?.page
            self?.photoData.removeAll()
            self?.searchResultVM.postAPI(self!.searchData)
        }, loadingView: loadingView)
        collectionView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        
        let collectionFooterView = UINib(nibName: "CollectionFooterView", bundle: nil)
        collectionView.register(collectionFooterView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionFooterView")
        
        loadAPI()
    }
    
    deinit {
        collectionView.dg_removePullToRefresh()
    }
    
    func loadAPI() {
        
        if !isLoading {
            isLoading = true
        }
        
        page += 1
        searchData["page"] = page
        searchResultVM.postAPI(searchData)
    }
}

extension SearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height: 55)
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
            collectionFooterView?.activityIndicatorView.startAnimating()
            loadAPI()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
        let photoModel = photoData[indexPath.row]
        cell.name.text = photoModel.title

        let id = photoModel.id
        let secret = photoModel.secret
        let photoUrl = URL(string: "https://farm1.staticflickr.com/2/\(id)_\(secret)_m.jpg")
        cell.imageView.sd_setImage(with: photoUrl) { (image, error, type, url) in

            cell.imageView.hideSkeleton()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let pohotModel = photoData[indexPath.row]
        
        let alert = UIAlertController(title: "", message: pohotModel.title, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
//
//            loadAPI()
//        }
    }
}
