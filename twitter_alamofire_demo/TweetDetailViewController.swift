//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by PJ Martinez on 3/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetDetailViewController: UIViewController {

    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userHandleLabel: UILabel!
    @IBOutlet var tweetTextLabel: UILabel!
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var timestampLabel: UILabel!
    
    var tweet: Tweet?
    var imageString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = tweet {
            usernameLabel.text = tweet.user.name
            usernameLabel.font = UIFont.boldSystemFont(ofSize: 17)
            imageString = tweet.user.profileImageUrl!
            let imageURL = URL(string: self.imageString)!
            userProfileImageView.af_setImage(withURL: imageURL)
            userHandleLabel.text = "@\(tweet.user.screenName)"
            userHandleLabel.textColor = .gray
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            timestampLabel.textColor = .gray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
