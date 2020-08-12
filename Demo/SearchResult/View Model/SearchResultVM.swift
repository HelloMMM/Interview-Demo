//
//  HomeVM.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import Foundation

class SearchResultVM {
    
    var person: Observable<Bool> = Observable(true)
    var photoData: [PhotoModel] = []
    var page: Int = 1
    var isLoading = false
    
    func nextLoadAPI(homeModel: HomeModel) {
        
        if !isLoading {
            isLoading = true
        }
        
        page += 1
        postAPI(homeModel: homeModel)
    }
    
    func postAPI(homeModel: HomeModel) {

        let per_page = homeModel.per_page
        let tags = homeModel.tags

        let parameters: Dictionary<String, Any> = ["ctl": "services",
                                                   "act": "rest",
                                                   "per_page": per_page,
                                                   "tags": tags,
                                                   "page": page]
        
        AlamofireManager.shared.requestAPI(parameters: parameters, onSuccess: { (response) in
            
            do {            
                let model = try JSONDecoder().decode(SearchResultModel.self, from: response.data!)
                
                if self.page == 1 {
                    self.photoData.removeAll()
                }
                
                self.photoData.append(contentsOf: model.photos.photo)
                
                if self.photoData.count == 0 {
                    self.person.value = false
                } else {
                    self.person.value = true
                }
            } catch let error {

                self.person.value = false
                print("postAPIError: \(error)")
            }
        }) { (error) in
            
            self.person.value = false
            print("postAPIError: \(error)")
        }
    }
}
