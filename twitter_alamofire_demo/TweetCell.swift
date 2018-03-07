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
    
    
    var imageString: String = ""
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            tweetTimeLabel.setText(" · " + tweet.createdAtString)
            
            userTitleLabel.setText(tweet.user.name)
            userNameLabel.setText("@" + tweet.user.screenName!)

            favoritesCountLabel.text = String(describing: tweet.favoriteCount)
            
            retweetsCountLabel.text = String(describing: tweet.retweetCount)
            
            imageString = tweet.user.profileImageUrl!
            let imageURL = URL(string: self.imageString)!
            userIconImageView.af_setImage(withURL: imageURL)
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited == false {
            tweet.favorited = true
            print("trying to favorite tweet")
            favoriteTweet()
        } else {
            tweet.favorited = false
            print("trying to unfavorite tweet")
            unfavoriteTweet()
        }
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            retweetTweet()
        }
    }
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }
        }
    }
    
    func retweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
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
                tweet.favoriteCount! -= 1
                self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
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
