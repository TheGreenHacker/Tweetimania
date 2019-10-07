//
//  ViewController.swift
//  Tweetimania
//
//  Created by Jack Li on 9/7/19.
//  Copyright © 2019 Jack Li. All rights reserved.
//

import UIKit
import SwifteriOS
import SwiftyJSON
import NaturalLanguage

class ViewController: UIViewController {
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let swifter = Swifter(consumerKey: "tHuzwg23jp6z3VnfGegv5ZxEn", consumerSecret: "J3RFRLopARFBtC9iRL1NyAdcVxIo2ETcP8FM31F6hPApcjo9NS")
    let sentimentPredictor = try! NLModel(mlModel: TweetSentiment().model)
    let numTweets = 100  // number of tweets to be scraped using Twitter API (but there might be less than that for inactive/unpopular handles)
    
    /* Numerical limits for determining public sentiment towards a handle/page based on average sentimental
     score. */
    let negLimit = 0.475
    let neuLimit = 0.525
    let posLimit = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func predict(_ sender: UIButton) {
        swifter.searchTweet(using: self.textField.text!, lang: "en", count: numTweets, tweetMode: .extended, success: { (statuses, _) in
            var tweets = [String]()
            for i in 0..<self.numTweets {
                if let tweet = statuses[i]["full_text"].string {
                    tweets.append(tweet)
                }
            }
            
            let score = self.makePredictions(for: tweets)
            //print(score)
            self.updateUI(with: score)
            
        }, failure: { (error) in
            print(error)
        })
    }
    
    /* Compute total sentimental score based on recent tweets for a handle/page by taking the average of the
     individual scores for each tweet (0 for negative and 1 for positive). If nobody has tweeted about the handle, return a neutral score of 0.5 (fair benefit of the doubt hehe). */
    func makePredictions(for tweets: [String]) -> Double {
        var score = 0.0
        for tweet in tweets {
            if let label = self.sentimentPredictor.predictedLabel(for: tweet) {
                score += (label == "Negative" ? 0.0 : 1.0)
            }
        }
        
        let avgScore = !tweets.isEmpty ? score/Double(tweets.count) : 0.5
        return avgScore
    }
    
    /* Update Emoji based on overall sentimental score limits as defined earlier. */
    func updateUI(with score: Double) {
        switch score {
        case 0..<self.negLimit:
            self.sentimentLabel.text = "☹️"
        case self.negLimit..<self.neuLimit:
            self.sentimentLabel.text = "😐"
        case self.neuLimit...self.posLimit:
            self.sentimentLabel.text = "🙂"
        default:
            self.sentimentLabel.text = "😐"
        }
    }
}
