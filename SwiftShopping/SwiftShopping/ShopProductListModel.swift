//
//  ShopProductListModel.swift
//  SwiftShopping
//
//  Created by Mac on 2022/9/4.
//

import UIKit
import HandyJSON

class ShopProductListModel: HandyJSON {
    var cover: String = ""
    var id:Int?
    var name: String?
    var price: Double?
    var rating:Int?
    var images:[String]?
    required init(){} // 必须实现一个空的初始化方法
}

