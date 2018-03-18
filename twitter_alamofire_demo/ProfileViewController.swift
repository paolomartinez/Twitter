//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by PJ Martinez on 3/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

    @IBOutlet var profilePictureImage: UIImageView!
    @IBOutlet var profileBackgroundImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userHandleLabel: UILabel!
    
    @IBOutlet var tweetCountLabel: UILabel!
    @IBOutlet var followingLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    
    let user = User.current!
    var imageString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageString = user.profileImageUrl!
        let imageURL = URL(string: self.imageString)!
        profilePictureImage.af_setImage(withURL: imageURL)
        //profileBackgroundImage.af_setImage(withURL: (user.profileBackgroundURL))
        
        usernameLabel.text = user.name
        userHandleLabel.text = "@\(user.screenName)"
        
        tweetCountLabel.text = "\(user.tweetsCount)"
        followingLabel.text = "\(user.followingCount)"
        followersLabel.text = "\(user.followersCount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
