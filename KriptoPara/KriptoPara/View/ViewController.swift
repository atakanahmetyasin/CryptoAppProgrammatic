//
//  ViewController.swift
//  KriptoPara
//
//  Created by Ahmet Yasin Atakan on 21.10.2023.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    let tableView = UITableView()
    let indicatorView = UIActivityIndicatorView()
    
    var cryptoList = [Crypto]()
    let disposeBag = DisposeBag()
    
    let cryptoVM = CryptoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        tableView.delegate = self
        tableView.dataSource = self
        setupUITableView()
        
        setupBindings()
        cryptoVM.requestData()
        
        // Do any additional setup after loading the view.
    }
    func setupBindings(){
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)//Dispatchquee.main.async gib
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
         
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe{error in
                print(error)
            }.disposed(by: disposeBag)
      
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        cryptoVM
                    .loading
                    .observe(on: MainScheduler.asyncInstance)
                    .subscribe { bool in
                        print(bool)
                    }.disposed(by: disposeBag)
            
        
    }
    
    func setupUITableView(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.currencyLabel.text = cryptoList[indexPath.row].currency
        cell.priceLabel.text = cryptoList[indexPath.row].price
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

