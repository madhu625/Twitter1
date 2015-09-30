//
//  TweetsViewController.swift
//  Twitter1
//
//  Created by Deepti Chinta on 9/27/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource {
    var tweets: [Tweet]?
    let CELL_NAME = "TwitterCell"
    var refreshControl = UIRefreshControl()


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
        
        let thisTweet = tweets![indexPath.row] as Tweet
        let thisUser = thisTweet.user! as User
        cell.TweetLabel.text = thisTweet.text! as String
        cell.NameLabel.text = thisUser.name! as String
        cell.ProfileImage.setImageWithURL(NSURL(string: thisUser.profileImageUrl!))
        cell.TagLabel.text = "@" + thisUser.screenname! as String
        cell.HourLabel.text = thisTweet.time!
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor = UIColor.blueColor()
        //CAE5FF
        self.navigationController!.navigationBar.barTintColor = UIColor(red:0.52, green:0.76, blue:1.00, alpha:0.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Do any additional setup after loading the view.
        self.refreshControl = UIRefreshControl()

        
        refreshControl.addTarget(self, action: "fetchTweets", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)
        self.fetchTweets()


  
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
    
        User.currentUser?.logout()
    }
    
    func fetchTweets() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets,error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }

    

}


class TwitterCell:UITableViewCell{
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var TweetLabel: UILabel!
    
    @IBOutlet weak var HourLabel: UILabel!

    @IBOutlet weak var TagLabel: UILabel!
    
}


