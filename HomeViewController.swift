//
//  File.swift
//  TwitterApp
//
//  Created by 俺の MacBook Air on 2024/06/04.
//

import RealmSwift
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetViewControllerDelegate {
    
    @IBOutlet weak var HomeTableView: UITableView!
    
    private var tweetDataModel: [TweetDataModel] = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // セルの登録
        HomeTableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        // UITableViewのデリゲートとデータソースの設定
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        
        // セルを可変
        HomeTableView.estimatedRowHeight = 50
        HomeTableView.rowHeight = UITableView.automaticDimension
        loadTweets()
    }
        
    func loadTweets() {
        let realm = try! Realm()
        let tweets = realm.objects(TweetDataModel.self)
        tweetDataModel = Array(tweets)
    }
        
    @IBAction func goTweetButton() {
        
        guard let goTweet = storyboard?.instantiateViewController(identifier: "second") as? tweetViewController else {
            return
        }
        goTweet.delegate = self
        navigationController?.pushViewController(goTweet, animated: true)
        
    }
        
    // セクションあたりの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataModel.count
    }
    
    // セルを構成する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweetDataModel[indexPath.row]
        cell.UserNameLabel.text = tweet.userName
        cell.TweetLabel.text = tweet.tweet
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // デリゲートメソッド
    func didSaveTweet(_ tweet: TweetDataModel) {
        tweetDataModel.append(tweet)
        HomeTableView.reloadData()
    }
}



