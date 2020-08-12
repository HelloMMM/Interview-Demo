//
//  HomeModel.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import Foundation

struct SearchResultModel: Codable {
    
    var photos: PhotosModel
    var stat: String
}

struct PhotosModel: Codable {
    
    var page: Int
    var pages: Int
    var perpage: Int
    var total: String
    var photo: Array<PhotoModel>
}

struct PhotoModel: Codable {
    
    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var ispublic: Int
    var isfriend: Int
    var isfamily: Int
}
