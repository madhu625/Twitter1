//
//  DetailsViewController.swift
//  Twitter1
//
//  Created by Deepti Chinta on 10/1/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var currentTweet: Tweet?
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTag: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var userTime: UILabel!
    @IBOutlet weak var userCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    
    
    @IBOutlet weak var retweetImage: UIImageView!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBAction func onHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    @IBAction func onReply(sender: AnyObject) {
    }



    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // self.navigationController!.navigationBar.barTintColor = UIColor(red:0.52, green:0.76, blue:1.00, alpha:0.0)
       // self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().barTintColor = UIColor(red:0.52, green:0.76, blue:1.00, alpha:0.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        print(currentTweet)

        self.userName.text = currentTweet?.user?.name
        self.userTag.text = "@" + currentTweet!.user!.screenname!
        self.userTweet.text = currentTweet?.text
        self.userImage.setImageWithURL(NSURL(string: currentTweet!.user!.profileImageUrl!))
        self.userTime.text = currentTweet?.createdAtString
        self.userCount.text = "10"
        self.favCount.text = "20"
        self.retweetLabel.text = ""
        self.retweetImage.hidden = true
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
