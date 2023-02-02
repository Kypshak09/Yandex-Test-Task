//
//  CompanyRequest.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 02.02.2023.
//

import Foundation
import Alamofire

class CompanyRequest {
    
    func getCompanyData(symbol: String, completion: @escaping (Result<CompanyData, Error>) -> Void) {
            let url = "https://finnhub.io/api/v1/stock/profile2?symbol=\(symbol)&token=cfblel1r01qot24sr0rgcfblel1r01qot24sr0s0"
            AF.request(url).responseDecodable(of: CompanyData.self) { response in
                switch response.result {
                case .success(let companyData):
                    completion(.success(companyData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}


