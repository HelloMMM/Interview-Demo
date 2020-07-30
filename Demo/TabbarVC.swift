//
//  ViewController.swift
//  Demo
//
//  Created by HellöM on 2020/7/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabbarVC: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
    }
    
    func initVC() {
        
        let homeVC = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC)
        let collectionVC = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionVC") as! CollectionVC)
        
        homeVC.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        collectionVC.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "收藏", image: UIImage(named: "collect"), selectedImage: UIImage(named: "collect-1"))
        
        tabBar.shadowImage = UIImage(named: "transparent")
        tabBar.backgroundImage = UIImage(named: "background_dark")
        
        viewControllers = [homeVC, collectionVC]
    }
}

