//
//  ComposeTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by PJ Martinez on 3/17/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var characterCountLabel: UILabel!
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var tweetTextView: UITextView! {
        didSet {
            tweetTextView.becomeFirstResponder()
            tweetTextView.delegate = self
        }
    }
    
    var delegate: ComposeTweetViewControllerDelegate?
    let maxCharCount = 140
    
    
    @IBAction func didPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        characterCountLabel.text = "\(maxCharCount - tweetTextView.text.count)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        return newText.count <= maxCharCount
    }
    
    @IBAction func didPressPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

protocol ComposeTweetViewControllerDelegate {
    func did(post: Tweet)
}
