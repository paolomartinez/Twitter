//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class TweetCell: UITableViewCell {
    
    @IBOutlet var userIconImageView: UIImageView!
    @IBOutlet var userNameLabel: TTTAttributedLabel!
    @IBOutlet var userTitleLabel: TTTAttributedLabel!
    
    @IBOutlet var tweetTimeLabel: TTTAttributedLabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            tweetTimeLabel.setText(" · " + tweet.createdAtString)
            
            userTitleLabel.setText(tweet.user.name)
            userNameLabel.setText("@" + tweet.user.screenName!)
            
            /*
            authorNameLabel.text = tweet.user.name
            twitterHandleLabel.text = "@" + tweet.user.screenName!
            timeStampLabel.text = " · " + tweet.createdAtString */
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
