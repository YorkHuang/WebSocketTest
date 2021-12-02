//
//  CoinTableViewCell.swift
//  WebSocketTest
//
//  Created by YorkMan on 2021/12/2.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
