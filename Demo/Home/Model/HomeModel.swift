//
//  HomeModel.swift
//  Demo
//
//  Created by HellöM on 2020/8/12.
//  Copyright © 2020 HellöM. All rights reserved.
//

import Foundation

struct HomeModel {
    var tags: String
    var per_page: Int
    
    init(tags: String, per_page: Int) {
        
        self.tags = tags
        self.per_page = per_page
    }
}

