//
//  CoinNewsTableViewCell.swift
//  CryptoCoinsNews
//
//  Created by Alaattin Bedir on 21.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import UIKit

class CoinNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let customColorView = UIView()
        customColorView.backgroundColor = UIColor.lightGray
        
        self.selectedBackgroundView =  customColorView
        // Configure the view for the selected state
    }
    
    
    
}
