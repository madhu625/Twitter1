//
//  Tweet.swift
//  Twitter1
//
//  Created by Deepti Chinta on 9/27/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var time:String?
    //var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
       // self.dictionary = dictionary
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        createdAt = formatter.dateFromString(createdAtString!)
        
        let now = NSDate()
        
        let timeDiff = Int(now.timeIntervalSinceDate(createdAt!))
        let minutes = (timeDiff / 60) % 60
        let hours = (timeDiff / 3600)
        
        if (hours > 23){
            time = String(format: "%01dh %01dm", hours, minutes)
        } else if (hours > 0) {
            time = String(format: "%01dh %01dm", hours, minutes)
        } else {
            time = String(format: "%01dm", minutes)
        }

        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
}
