//
//  RequestPrice.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 30.01.2023.
//

import Foundation
import Alamofire

class RequestsPrice {
    
    func getData(_ urlStr: String,  handler: @escaping (_ apiData: PriceModel) -> ()) {
        let url = URL(string: urlStr)!
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(PriceModel.self, from: data!)
                    handler(jsonData)
                    
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
