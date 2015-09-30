//
//  ComposeViewController.swift
//  Twitter1
//
//  Created by Deepti Chinta on 9/29/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var TagLabel: UILabel!
    
    
    @IBOutlet weak var TweetText: UITextView!

    
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func onTweet(sender: AnyObject) {
        var params = NSDictionary()
        params = ["status" : TweetText.text!]
        print ("here")
        
        print(params)
        TwitterClient.sharedInstance.postTweet(params, completion: {(error) -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor = UIColor(red:0.52, green:0.76, blue:1.00, alpha:0.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.UserLabel.text = User.currentUser!.name
        //self.UserImage.setImageWithURL(User.currentUser!.profile_image_url)
        self.UserImage.setImageWithURL(NSURL(string: User.currentUser!.profileImageUrl!))
        self.TagLabel.text = "@" + User.currentUser!.screenname! as String


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
