//
//  ShopCollectionVC.swift
//  SwiftShopping
//
//  Created by Ze Shao on 2022/10/15.
//

import UIKit
import MJRefresh

class ShopCollectionVC: UIViewController {
    var myTableView : UITableView?
    var resultArray : [ShopProductListModel] = [ShopProductListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "Collection"
        self.view.backgroundColor = .white
        self.loadMainPageView()
        //self.refreshPageListEvent()
        // Do any additional setup after loading the view.
    }
    
    func loadMainPageView() {
        let myTableView = UITableView.init(frame:CGRect.init(x: 0, y: 0, width: 0, height: 0) , style: .plain)
        myTableView.register(ShopProductListCell.self, forCellReuseIdentifier: ShopProductListCell.description())
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.delegate = self
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
        NSLayoutConstraint.activate([
            myTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            myTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            myTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
//        let headerRefresh = MJRefreshNormalHeader{
//            print("headerRefreshfdf")
//            //self.requestPageLst()
//        }
//        headerRefresh.stateLabel?.isHidden = true
//        headerRefresh.lastUpdatedTimeLabel?.isHidden = true
//        myTableView.mj_header = headerRefresh
        self.myTableView = myTableView
    }
    
    
    func refreshPageList(listAray : [ShopProductListModel]) {
        self.resultArray = listAray
        self.myTableView?.reloadData()
    }
    
    func refreshPageListEvent() {
        let storeTool = ShopStoreLocallyTool()
        let arraySource = storeTool.getSourceData()
        self.resultArray = arraySource
        self.myTableView?.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShopCollectionVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultCell : ShopProductListCell = tableView.dequeueReusableCell(withIdentifier: ShopProductListCell.description(), for: indexPath) as! ShopProductListCell
        let itemMode : ShopProductListModel = self.resultArray[indexPath.row]
        resultCell.recePageModel(datModel: itemMode)
        resultCell.selecRowNum = indexPath.row
        resultCell.selectRowIndex = { [self] (selectRo) -> Void in
            var result : [ShopProductListModel] = [ShopProductListModel]()
            for cellRow in 0..<resultArray.count {
                let itemModel : ShopProductListModel = resultArray[cellRow]
                if cellRow == selectRo {
                    itemModel.isCollection = !itemModel.isCollection
                }
                result.append(itemModel)
            }
            resultArray = result
            self.myTableView?.reloadData()
        }
        //resultCell.textLabel?.text = "the index is \(indexPath.row)"
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

extension ShopCollectionVC : UITableViewDelegate {
    
}
