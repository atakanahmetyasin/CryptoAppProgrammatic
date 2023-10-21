//
//  TableViewCell.swift
//  KriptoPara
//
//  Created by Ahmet Yasin Atakan on 21.10.2023.
//

import Foundation
import UIKit

var cryptoList = [Crypto]()

class TableViewCell : UITableViewCell{
    
    let currencyLabel : UILabel = {
        let currencyLabel = UILabel()
        currencyLabel.textAlignment = .left
        currencyLabel.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        return currencyLabel
    }()
    
    let priceLabel : UILabel = {
        let priceLabel = UILabel()
        priceLabel.textAlignment = .left
        priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()
  
    
    private func addViews(){
        backgroundColor = .clear
        addSubview(currencyLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: topAnchor,constant: 30),
            currencyLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            currencyLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 10),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
   
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
}

