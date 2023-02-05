import Alamofire

class PriceRequest {
    var price = [PriceData]()
    func getPrice(symbol: String, handler: @escaping([PriceData]) -> Void) {
        let url = "https://finnhub.io/api/v1/quote?symbol=\(symbol)&token=cfblel1r01qot24sr0rgcfblel1r01qot24sr0s0"
        AF.request(url).responseDecodable(of:PriceData.self) {response in
            switch response.result {
            case .success(let priceData):
                print(priceData)
                self.price.append(priceData)
                handler(self.price)
            case .failure(let error):
                print(error)
            }
        }
    }
}
