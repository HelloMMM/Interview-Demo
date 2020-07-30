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
    
    let baseUrl = "https://www.flickr.com/services/rest/"
    var formalParameters: Dictionary<String, Any> = ["api_key": "2ac945871a3ff14c42a885dd9fcef862",
                                                     "method": "flickr.photos.search",
                                                     "format": "json",
                                                     "nojsoncallback": 1]
   
    func requestAPI(parameters: Dictionary<String, Any>, onSuccess: @escaping ([PhotoModel]) -> (), onError: @escaping (Error) -> ()) {
        
        for (key, value) in parameters {
            
            formalParameters[key] = value
        }
        
        AF.request(baseUrl, method: .post, parameters: formalParameters, encoding: URLEncoding.default).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let responseJson = json as! Dictionary<String, Any>
                let photos = responseJson["photos"] as! Dictionary<String, Any>
                let photo = photos["photo"] as! Array<Any>

                do {
                    let data = try JSONSerialization.data(withJSONObject: photo, options: [])
                    do {
                        
                        let model = try JSONDecoder().decode([PhotoModel].self, from: data)
                        onSuccess(model)
                    } catch let error {

                        onError(error)
                    }
                } catch let error {

                    onError(error)
                }
            case .failure(let error):
                onError(error)
            }
            
        }
    }
}
