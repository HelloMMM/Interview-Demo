//
//  HomeVM.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import Foundation

class SearchResultVM {
    
    var person: Observable<[PhotoModel]> = Observable([])
    
    func postAPI(_ data: Dictionary<String, Any>) {

        let per_page = data["per_page"] as! Int
        let tags = data["tags"] as! String
        
        let parameters: Dictionary<String, Any> = ["per_page": per_page,
                                                   "tags": tags]
        AlamofireManager.shared.requestAPI(parameters: parameters, onSuccess: { (photo: [PhotoModel]) in
            
            self.person.value = photo
        }) { (error) in
            
            print(error)
        }
    }
}
