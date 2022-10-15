//
//  ViewController.swift
//  SwiftShopping
//
//  Created by Mac on 2022/9/4.
//

import UIKit
import MJRefresh

class ShopProductListVC: UIViewController {

    var myTableView : UITableView?
    var resultArray : [ShopProductListModel] = [ShopProductListModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "Shop"
        // Do any additional setup after loading the view.
        self.loadMainPageView()
        self.requestPageLst()
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
        
        let headerRefresh = MJRefreshNormalHeader{
            print("headerRefreshfdf")
            self.requestPageLst()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                self.myTableView?.mj_header?.endRefreshing()
//            }
        }
        headerRefresh.stateLabel?.isHidden = true
        headerRefresh.lastUpdatedTimeLabel?.isHidden = true
        myTableView.mj_header = headerRefresh
        self.myTableView = myTableView
    }
    
    func refreshHeaderView() {
        
    }
    
    func requestPageLst() {
        ShopProductListNetWork.requestPageContentList {[weak self] resultArrayTH in
            self?.myTableView?.mj_header?.endRefreshing()
            self?.resultArray = resultArrayTH
            self?.myTableView?.reloadData()
        }
    }
}

extension ShopProductListVC : UITableViewDataSource {
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
                    self.handleSelectItem(itemModel)
                }
                result.append(itemModel)
            }
            resultArray = result
            self.myTableView?.reloadData()
        }
        //resultCell.textLabel?.text = "the index is \(indexPath.row)"
        return resultCell
    }
    
    func handleSelectItem(_ itemModel : ShopProductListModel) {
//        let storeTool = ShopStoreLocallyTool()
        let shopRoot = self.getCurrentWindwo().rootViewController as? ShopRootTabbarVC
        let collectionShop = shopRoot?.collectionVC
        var arraySource = collectionShop?.resultArray //storeTool.getSourceData()
        if itemModel.isCollection {
            arraySource?.append(itemModel)
        } else {
            for index in 0..<(arraySource?.count ?? 0) {
                let selecModel = arraySource?[index];
                if selecModel?.id == itemModel.id {
                    arraySource?.remove(at: index)
                    break
                }
            }
        }
//        storeTool.wirtFileWithContent(arraySource)

        collectionShop?.refreshPageList(listAray: arraySource ?? [ShopProductListModel]())
    }
    
    func getCurrentWindwo() -> UIWindow {
        var window: UIWindow? = nil
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .last?.windows
                //.filter({ $0.isKeyWindow })
                .last
        } else {
            window = UIApplication.shared.keyWindow
        }
        return window ?? UIWindow()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}

extension ShopProductListVC : UITableViewDelegate {
    
}
