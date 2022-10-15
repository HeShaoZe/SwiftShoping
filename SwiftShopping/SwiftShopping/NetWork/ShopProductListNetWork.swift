//
//  ShopProductListNetWork.swift
//  SwiftShopping
//
//  Created by Mac on 2022/9/4.
//

import UIKit
import Moya
import HandyJSON

class ShopProductListNetWork: NSObject {
    typealias requestDataListCallBack = (_ resultArray : [Any]) ->()
    typealias successCallBack = (_ resultArrayTH : [ShopProductListModel]) -> Void
    static func requestPageContentList(_ resultCallArray : successCallBack?) {
        let provider = MoyaProvider<ShopManagerApi>();
        provider.request(.requestPageListData) { result in
            switch result{
            case .success(let respon):
                //解析数据
                let data = try? respon.mapJSON()
//                let json = transformToJSON(<#T##NSDecimalNumber?#>)
                print("请求成功+++++:\(String(describing: data))" )
                var resultArray : [ShopProductListModel] = [ShopProductListModel]()
                let resultString = String(describing: data);
                let compost: [ShopProductListModel]  = try! JSONDeserializer<ShopProductListModel>.deserializeModelArrayFrom(json:respon.mapString()) as! [ShopProductListModel]
                resultCallArray!(compost)
                print("errfddfdfdfdfor:\(String(describing: compost))")
//                do {
//                    let anyResult = try respon.mapJSON()
//                    print("requestResult:\(anyResult)")
//                } catch {
//                    print(error)
//                }
            case .failure(let error):
                print("error:\(error.localizedDescription)")
            }
            
            
        }
    }
}
