//
//  ShopProductListCell.swift
//  SwiftShopping
//
//  Created by Mac on 2022/9/4.
//

import UIKit
import SDWebImage

class ShopProductListCell: UITableViewCell {

    private var converView: UIImageView!
    private var nameLable : UILabel!
    private var ratingView : UIView!
    private var priceLable : UILabel!
    private var collectionButton : UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loadMainPageView()
    }
    
    func loadMainPageView() {
        let hstactView = UIStackView.init()
        hstactView.translatesAutoresizingMaskIntoConstraints = false
        hstactView.spacing = 8
        self.contentView.addSubview(hstactView)
        
        let converView = UIImageView.init()
        converView.image = UIImage.init(named: "heart.fill")
        contentView.contentMode = .scaleAspectFill
        hstactView.addArrangedSubview(converView)
        self.converView = converView
        
        NSLayoutConstraint.activate([
            hstactView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            hstactView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant:-16),
            hstactView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            converView.widthAnchor.constraint(equalToConstant: 100),
            converView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        ///名字和评分
        let vStackView = UIStackView.init()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 6
        vStackView.axis = .vertical
        hstactView.addArrangedSubview(vStackView)
        
        nameLable = UILabel.init()
        nameLable.font = UIFont.systemFont(ofSize: 16)
        vStackView.addArrangedSubview(nameLable)
        
        ratingView = UIView.init()
        ratingView.translatesAutoresizingMaskIntoConstraints = true
        ratingView.backgroundColor = .red
        vStackView.addArrangedSubview(ratingView)
        NSLayoutConstraint.activate([
            ratingView.widthAnchor.constraint(equalToConstant: 100),
            ratingView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let butSctView = UIStackView()
        butSctView.spacing = 8
        vStackView.addArrangedSubview(butSctView)
        
        priceLable = UILabel.init()
        priceLable.textColor = .orange
        priceLable.text = "$12"
        priceLable.font = UIFont.systemFont(ofSize: 14)
        butSctView.addArrangedSubview(priceLable)
        
        collectionButton = UIButton.init()
        collectionButton.backgroundColor = .green
        collectionButton.setImage(UIImage.init(named: "heart"), for: .normal)
        collectionButton.setImage(UIImage.init(named: "heart.fill"), for: .selected)
        butSctView.addArrangedSubview(collectionButton)
        NSLayoutConstraint.activate([
            collectionButton.widthAnchor.constraint(equalToConstant:60),
            collectionButton.heightAnchor.constraint(equalToConstant:30)
        ])
    }
    /**
     private var converView: UIImageView!
     private var nameLable : UILabel!
     private var ratingView : UIView!
     private var priceLable : UILabel!
     private var collectionButton : UIButton!
     
     */
    
    func recePageModel(datModel : ShopProductListModel) {
        var urlString = "https://gitee.com/xiaoyouxinqing/Learn-iOS-from-Zero/raw/main/API/Shopping/Image/\(datModel.cover)"
        urlString = "\(urlString)"
        print("coverfdjjf--\(datModel.cover)--\(urlString)")
        self.converView.sd_setImage(with: URL.init(string: urlString))
        self.nameLable.text = datModel.name
        self.priceLable.text = String.init(format: "$%.2f", datModel.price!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
