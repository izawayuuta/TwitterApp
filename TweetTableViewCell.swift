//
//  TweetTableViewCell.swift
//  TwitterApp
//
//  Created by 俺の MacBook Air on 2024/06/05.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tweetLabel.numberOfLines = 0
        userNameLabel.numberOfLines = 1 // ユーザー名は1行で表示する
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
