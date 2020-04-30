
import Foundation

protocol CoinManagerDelegate {
    func didUpdateValue(_ price: String, _ currency: String)
    func didFailWithError(_ error: Error)
}


struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6BE76F5B-D2D9-4E53-8C7E-7F7FF035185D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(_ currency: String){
       
        let urlString = baseURL + "/\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let coinData = self.parseJson(safeData){
                        let price = String(format: "%.2f", coinData.rate)
                        self.delegate?.didUpdateValue(price, currency)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    
    func parseJson(_ data: Data) -> CoinData? {
        
        let decoder = JSONDecoder()
        
        do{
            let coinData = try decoder.decode(CoinData.self, from: data)
            return coinData
        }
        catch{
            return nil
        }
    }
    
}
