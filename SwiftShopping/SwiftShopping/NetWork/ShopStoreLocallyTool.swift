//
//  ShopStoreLocallyTool.swift
//  SwiftShopping
//
//  Created by Ze Shao on 2022/10/15.
//

import UIKit
import HandyJSON

class ShopStoreLocallyTool: NSObject {
    func fileHomePath() -> String {
        let homePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        if let pathString = homePath.first {
            return pathString
        }
        return ""
    }
    
    //获取或者新建文件路径
    func storgePathInterviewFormSandbox() -> String {
        let directoryPath = fileHomePath()+"PassesStorageDirectory";
        let fileManag = FileManager.default;
        if (!fileManag.fileExists(atPath: directoryPath))
        {
            try? fileManag.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil);
        }
        
        let filePathString = directoryPath + "/" + "InterviewQuestionsFile";
        
        if (!fileManag.fileExists(atPath: filePathString))
        {
            fileManag.createFile(atPath: filePathString, contents: nil, attributes: nil);
        }
        return filePathString;
    }
    
    ///写入
    func wirtFileWithContent(_ contentList : Array<ShopProductListModel>) {
        let storgePath = self.storgePathInterviewFormSandbox();
        let jsonString = contentList.toJSON()
        do {
            try jsonString.description.write(toFile: storgePath, atomically: true, encoding: .utf8)
            print("jsonStringfd--\(jsonString)--\(storgePath)")
        } catch {
            
        }

    }
    
    ///获取数据
    func getSourceData() ->Array<ShopProductListModel> {
        let storgePath = self.storgePathInterviewFormSandbox();
        let fileData = FileHandle.init(forReadingAtPath: storgePath)
        if let listDataContent = fileData?.readDataToEndOfFile() {
            let jsonStr = String(data: listDataContent, encoding: .utf8)
            do {
                let anydict = try JSONSerialization.jsonObject(with: listDataContent)
                    print("anydictfdfd--\(anydict)")
            } catch {
                
            }
         
            print("listJsonfdf--\(jsonStr)")
            let compost: [ShopProductListModel]  = JSONDeserializer<ShopProductListModel>.deserializeModelArrayFrom(json:jsonStr) as! [ShopProductListModel]
            return compost
        }
        /*do {
            let listJson = try String.init(contentsOfFile: storgePath)
            let listDataContent = listJson
            if listJson.count > 0 {
                if let listData = listJson.data(using: .utf8) {
                    let resultString = "\(listJson)"///nsdataToJSON(data: listData)
                    
                    if resultString != nil {
                        print("listJsonfdf--\(resultString)")
                    }
                    print("listJsonfdf-fd-\(resultString)")
                    let compost: [ShopProductListModel]  = JSONDeserializer<ShopProductListModel>.deserializeModelArrayFrom(json:resultString) as! [ShopProductListModel]
                    return compost
                }
        
            }
        } catch {
            
        }*/
        return Array<ShopProductListModel>();
    }
    
    
}
