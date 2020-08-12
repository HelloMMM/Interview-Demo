//
//  AlamofireManager.swift
//  iCanCheckInApp
//
//  Created by HellöM on 2020/3/30.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireManager: NSObject {
    
    static let shared = AlamofireManager()
    
    let baseUrl = "https://www.flickr.com/"
    var formalParameters: Dictionary<String, Any> = ["api_key": api_key,
                                                     "method": "flickr.photos.search",
                                                     "format": "json",
                                                     "nojsoncallback": 1]
   
    func requestAPI(parameters: Dictionary<String, Any>, onSuccess: @escaping (AFDataResponse<Any>) -> (), onError: @escaping (Error) -> ()) {
        
        NVLoadingView.startBlockLoadingView()
        
        let url = getUrlStr(parameters: parameters)
        
        for (key, value) in parameters {
            
            formalParameters[key] = value
        }
        
        AF.request(url, method: .post, parameters: formalParameters, encoding: URLEncoding.default).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                
                onSuccess(response)
            case .failure(let error):
                onError(error)
            }
            
            NVLoadingView.stopBlockLoadingView()
        }
    }
    
    func getUrlStr(parameters: Dictionary<String, Any>) -> String {
        
        let ctl = parameters["ctl"] as! String
        let act = parameters["act"] as! String
        
        let url = "\(baseUrl)\(ctl)/\(act)"
        
        return url
    }
}
