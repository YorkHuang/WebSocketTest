//
//  ViewController.swift
//  WebSocketTest
//
//  Created by YorkMan on 2021/12/2.
//

import UIKit
import Starscream

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WebSocketFetchDelegate {
    
    @IBOutlet weak var coinTableView: UITableView!
    var coins: [Coin] = []
    var webSocketFetch = WebSocketFetch()
    var refreshTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinTableView.register(UINib(nibName: "CoinTableViewCell", bundle: nil),forCellReuseIdentifier: "CoinTableViewCell")
        coinTableView.delegate = self
        coinTableView.dataSource = self
        coinTableView.showsVerticalScrollIndicator = false
        webSocketFetch.fetchDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.coins.removeAll()
        self.coins.append(Coin(time: "時間", price: "價格", quantity: "數量"))
        self.startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.stopTimer()
    }
    
    func startTimer() {
        if refreshTimer != nil {
            refreshTimer?.invalidate()
        }
        refreshTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(reupload(_:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        refreshTimer?.invalidate()
    }
    
    @objc func reupload(_ time: Timer) {
        DispatchQueue.main.async {
            self.coinTableView.reloadData()
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinTableViewCell", for: indexPath) as! CoinTableViewCell
        cell.timeLabel.text = coins[indexPath.row].time
        cell.priceLabel.text = coins[indexPath.row].price
        cell.quantityLabel.text = coins[indexPath.row].quantity
        return cell
    }

    //MARK: WebSocketFetchDelegate
    func didResponseCoinData(data: Coin) {
        self.coins.insert(data, at: 1)
        self.coins.append(data)
        if (coins.count > 41) {
            coins.removeLast()
        }
    }
    
    
}

