//
//  TwitterClient.swift
//  Twitter1
//
//  Created by Deepti Chinta on 9/27/15.
//  Copyright © 2015 DeeptiChinta. All rights reserved.
//

import UIKit

let twitterConsumerKey = "wutyQimPyMr4vNlD5XbxuoQ0j"
let twitterConsumerSecret = "aJKsbwWzDVydK7o6pzjY557ETp0hWxI25glxp285P0BeEvdM6A"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")



class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL:twitterBaseURL,consumerKey:twitterConsumerKey,consumerSecret:twitterConsumerSecret )

        }
        return Static.instance
    }
    
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
       GET("1.1/statuses/home_timeline.json", parameters: params, success: {(operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
        completion(tweets:tweets, error: nil)

        
            }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                print ("Error getting Home timeline")
                completion(tweets:nil, error:error)
                
        })
        
    }
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!)-> Void in
            print("Got the request token")
            var authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            
            }) { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }

    }
    
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString:url.query), success: {(accessToken:BDBOAuth1Credential!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: {(operation:AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                // print("User: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print ("user: \(user.name)")
                
                self.loginCompletion?(user:user,error: nil)
                
                }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                    print ("Error getting Current user")
                    self.loginCompletion?(user: nil, error: error)
                    
            })
            
           
            
            
            }) { (error:NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)

        }

        
    }

}
