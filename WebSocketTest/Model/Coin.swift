//
//  Coin.swift
//  WebSocketTest
//
//  Created by YorkMan on 2021/12/2.
//

import Foundation

class Coin {
 
    var time: String
    var price: String
    var quantity: String
    
    init(time: String, price: String, quantity: String) {
        self.time = time
        self.price = price
        self.quantity = quantity
    }
}
    
