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
    @IBOutlet weak var searchBtn: UIButton!
    var searchBtnIsEnabled = false {
        didSet {
            if searchBtnIsEnabled {
                
                searchBtn.backgroundColor = .systemBlue
            } else {
                
                searchBtn.backgroundColor = .systemGray
            }
            searchBtn.isEnabled = searchBtnIsEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchLab.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        pageNumber.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    @IBAction func searchClick(_ sender: UIButton) {
        
        let searchResultVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
        
        let homeModel = HomeModel(tags: searchLab.text!, per_page: Int(pageNumber.text!)!)
        searchResultVC.searchResultVM.homeModel = homeModel
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension HomeVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == searchLab {
            
            pageNumber.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @objc func textFieldChange() {
        
        if searchLab.text!.isEmpty || pageNumber.text!.isEmpty {
            
            searchBtnIsEnabled = false
        } else {
            
            if let _ = Int(pageNumber.text!) {
                searchBtnIsEnabled = true
            } else {
                searchBtnIsEnabled = false
            }
        }
    }
}
