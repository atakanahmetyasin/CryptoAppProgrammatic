//
//  Webservice.swift
//  KriptoPara
//
//  Created by Ahmet Yasin Atakan on 21.10.2023.
//

import Foundation

class Webservice {
    
    enum CryptoError : Error{
        case serverError
        case decodingError
        case urlError
    }
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completion(.failure(.serverError))
            }else if let data = data{
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
        
    }
}
