//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet var userIconImageView: UIImageView!
    @IBOutlet var userNameLabel: TTTAttributedLabel!
    @IBOutlet var userTitleLabel: TTTAttributedLabel!
    
    @IBOutlet var tweetTimeLabel: TTTAttributedLabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet var repliesCountLabel: UILabel!
    @IBOutlet var favoritesCountLabel: UILabel!
    @IBOutlet var retweetsCountLabel: UILabel!
    
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var retweetButton: UIButton!
    
    var favorited: Bool?
    var retweeted: Bool?
    var imageString: String = ""
    var tweet: Tweet! {
        didSet {
            // User objects on the view
            userTitleLabel.setText(tweet.user.name)
            userTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            userNameLabel.setText("@" + tweet.user.screenName)
            userNameLabel.textColor = .gray
            imageString = tweet.user.profileImageUrl!
            let imageURL = URL(string: self.imageString)!
            userIconImageView.af_setImage(withURL: imageURL)

            // Tweet objects on the view
            tweetTextLabel.text = tweet.text
            favorited = tweet.favorited!
            retweeted = tweet.retweeted
            tweetTimeLabel.setText("• " + tweet.timeAgoSinceNow)
            tweetTimeLabel.textColor = .gray
            updateUI()
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited == false {
            tweet.favorited = true
            favoriteTweet()
        } else {
            tweet.favorited = false
            unfavoriteTweet()
        }
        updateUI()
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            retweetTweet()
        } else {
            tweet.retweeted = false
            unretweetTweet()
        }
        updateUI()
    }
    
    func updateUI() {
        //Tweets Favorited case
        if tweet.favorited == true {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        //Tweets Retweeted case
        if tweet.retweeted == true {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        if tweet.retweetCount > 0 {
            retweetsCountLabel.text = "\(tweet.retweetCount)"
        } else {
            retweetsCountLabel.text = ""
        }
        if tweet.favoriteCount! > 0 {
            favoritesCountLabel.text = "\(tweet.favoriteCount!)"
        } else {
            favoritesCountLabel.text = ""
        }
    }
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.favoritesCountLabel.text = "\(tweet.favoriteCount! + 1)"
                self.updateUI()
            }
        }
    }
    
    func unfavoriteTweet() {
        APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                tweet.favorited = false
                self.favoritesCountLabel.text = "\(tweet.favoriteCount! - 1)"
                self.updateUI()
            }
        }
    }
    
    func retweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                tweet.retweetCount += 1
                self.updateUI()
            }
        }
    }
    
    func unretweetTweet() {
        APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error untweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                tweet.retweeted = false
                tweet.retweetCount -= 1
                self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
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
