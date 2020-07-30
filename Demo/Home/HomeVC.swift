//
//  HomeVC.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var searchLab: UITextField!
    @IBOutlet weak var pageNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func searchClick(_ sender: UIButton) {
        
        if searchLab.text!.isEmpty {
            searchLab.shake()
            showToast("請輸入項目")
            return
        }
        
        if pageNumber.text!.isEmpty {
            pageNumber.shake()
            showToast("請輸入數量")
            return
        }
        
        let searchResultVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
        
        let dic: Dictionary<String, Any> = ["tags": searchLab.text!,
                                            "per_page": Int(pageNumber.text!)!]
        searchResultVC.searchData = dic
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension HomeVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
