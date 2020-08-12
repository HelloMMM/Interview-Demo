//
//  CollectionVM.swift
//  Demo
//
//  Created by HellöM on 2020/8/12.
//  Copyright © 2020 HellöM. All rights reserved.
//

import Foundation

class CollectionVM {
    
    var person: Observable<Bool> = Observable(true)
    var photoModels: [PhotoModel] = []
    
    func dataProcess() {
        
        photoModels = collectionLibrary.map({ (item) in
            
            let id = item.value(forKey: "id") as! String
            let owner = item.value(forKey: "owner") as! String
            let secret = item.value(forKey: "secret") as! String
            let server = item.value(forKey: "server") as! String
            let farm = item.value(forKey: "farm") as! Int
            let title = item.value(forKey: "title") as! String
            let ispublic = item.value(forKey: "ispublic") as! Int
            let isfriend = item.value(forKey: "isfriend") as! Int
            let isfamily = item.value(forKey: "isfamily") as! Int
            
            let photoModel = PhotoModel(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title, ispublic: ispublic, isfriend: isfriend, isfamily: isfamily)
            
            return photoModel
        })
        
        person.value = true
    }
}
