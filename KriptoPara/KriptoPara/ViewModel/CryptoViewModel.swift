//
//  CryptoViewModel.swift
//  KriptoPara
//
//  Created by Ahmet Yasin Atakan on 21.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        
        Webservice().downloadCurrencies(url: url!) { result in
            self.loading.onNext(false)
            switch result{
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
            case .failure(let error):
                switch error{
                case .urlError:
                    self.error.onNext("URL'de Hata var")
                case .decodingError:
                    self.error.onNext("Decoding'te Hata var")
                case .serverError:
                    self.error.onNext("Server'da sıkıntı var")
                }
            }
        }
        
    }
    
}
