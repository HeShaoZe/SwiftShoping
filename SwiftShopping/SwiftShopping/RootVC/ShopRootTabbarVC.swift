//
//  ShopRootTabbarVC.swift
//  SwiftShopping
//
//  Created by Ze Shao on 2022/10/15.
//

import UIKit

class ShopRootTabbarVC: UITabBarController {

    let collectionVC = ShopCollectionVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadMainPage()
    }
    
    func loadMainPage() {
        let populaVC = ShopProductListVC()
   
        let meVC = ShopMeVC()
        
        if let shopImage = UIImage(named: "shop_home") {
            setNavigationView(populaVC, "Shop", shopImage, 0)
        }
        if let shopImage = UIImage(named: "shop_collection") {
            setNavigationView(collectionVC, "Collection", shopImage, 0)
        }
        if let shopImage = UIImage(named: "shop_me") {
            setNavigationView(meVC, "Me", shopImage, 0)
        }
    }
    
    func setNavigationView(_ sonViewController :UIViewController,_ title : String, _ itemImage : UIImage, _ vcTag : Int){
        sonViewController.tabBarItem = UITabBarItem(title: title, image: itemImage, tag: vcTag)
        let normalNav = UINavigationController.init(rootViewController: sonViewController)
        self.addChild(normalNav)
    }
}
