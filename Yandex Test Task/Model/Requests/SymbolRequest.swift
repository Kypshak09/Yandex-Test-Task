//
//  RequestSymbols.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 02.02.2023.
//

import Foundation
import Alamofire

class SymbolRequest {    
    var symbols = [SymbolData]()
    func getSymbols(completion: @escaping ([SymbolData]?) -> Void) {
            let url = "https://finnhub.io/api/v1/stock/symbol?exchange=US&token=cfblel1r01qot24sr0rgcfblel1r01qot24sr0s0"
            AF.request(url).responseDecodable(of: [SymbolData].self) { (response) in
                switch response.result {
                case .success(let symbolsData):
                    self.symbols = symbolsData
                    print(self.symbols)
                    completion(symbolsData)
                case .failure(let error):
                    print(error)
                    completion(nil)
                }
            }
        }
    }
