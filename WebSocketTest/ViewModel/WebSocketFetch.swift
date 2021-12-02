//
//  WebSocketFetch.swift
//  WebSocketTest
//
//  Created by YorkMan on 2021/12/2.
//

import Foundation

protocol WebSocketFetchDelegate {
    func didResponseCoinData(data: Coin)
}

class WebSocketFetch: WebSocketUtilDelegate {
    
    var webSocketUtil = WebSocketUtil()
    var fetchDelegate: WebSocketFetchDelegate?
    
    init() {
        webSocketUtil.delegate = self
        webSocketUtil.connectServer()
    }
    
    private func getTimeformat(unixtimeInterval: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixtimeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    //MARK: WebSocketDelegate
    func didReceivedResponse(msgData: String) {
        
        do {
            let data = msgData.data(using: .utf8)!
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                let time = (json["data"] as? [String: Any])!["T"] as? Int64 ?? 0
                let price = (json["data"] as? [String: Any])!["p"] as? String ?? ""
                let quantity = (json["data"] as? [String: Any])!["q"] as? String ?? ""
                let strTime = self.getTimeformat(unixtimeInterval: time)
                let coin = Coin(time: strTime, price: price, quantity: quantity)
                self.fetchDelegate?.didResponseCoinData(data: coin)
            }
        } catch let error {
            print(error)
        }
    }
    
    func didConnect() {
        
    }
    
    func didDisconnect() {
        webSocketUtil.connectServer()
    }
    
    func didReceivedFail(error: String) {
        print(error)
    }
    
    
}
