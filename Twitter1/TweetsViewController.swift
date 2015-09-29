//
//  TweetsViewController.swift
//  Twitter1
//
//  Created by Deepti Chinta on 9/27/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit
//import AFNetworking


class TweetsViewController: UIViewController {
    var tweets: [Tweet]?
    let CELL_NAME = "TwitterCell"

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = tweets {
            return array.count
        } else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! TwitterCell
        cell.NameLabel.text = "here"
        
        let thisTweet = tweets![indexPath.row] as Tweet
        let thisUser = thisTweet.user! as User
        cell.TweetLabel.text = thisTweet.text! as String
        cell.NameLabel.text = thisUser.name! as String
        cell.ProfileImage.setImageWithURL(NSURL(string: thisUser.profileImageUrl!))
        cell.TagLabel.text = "@" + thisUser.screenname! as String


        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets,error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()

            
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    

}


class TwitterCell:UITableViewCell{
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var TweetLabel: UILabel!
    
    @IBOutlet weak var HourLabel: UILabel!
    
    

    @IBOutlet weak var TagLabel: UILabel!
    
}


