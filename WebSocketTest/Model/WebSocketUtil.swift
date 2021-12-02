//
//  WebSocket.swift
//  WebSocketTest
//
//  Created by YorkMan on 2021/12/2.
//

import Foundation
import Starscream

protocol WebSocketUtilDelegate {
    func didReceivedResponse(msgData: String)
    func didConnect()
    func didDisconnect()
    func didReceivedFail(error: String)
}



class WebSocketUtil: WebSocketDelegate{
    
    let url = "wss://stream.yshyqxx.com/stream?streams=btcusdt@trade"
    var delegate: WebSocketUtilDelegate?
    var socket: WebSocket
    
    init() {
        var request = URLRequest(url: URL(string: url)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
    }
    
    func connectServer() {
        socket.connect()
    }
    
    func sendBrandStr(brandID: String){
        socket.write(string: brandID)
    }
      
    func disconnect(){
        socket.disconnect()
    }
    
    //MARK: WebSocketDelegate
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                self.delegate?.didConnect()
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                self.delegate?.didDisconnect()
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
            self.delegate?.didReceivedResponse(msgData: "\(string)")
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                self.delegate?.didDisconnect()
            case .error(let error):
                self.delegate?.didDisconnect()
                self.delegate?.didReceivedFail(error: "\(String(describing: error))")
            }
    }
    
    
}
