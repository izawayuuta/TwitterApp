//
//  File.swift
//  TwitterApp
//
//  Created by 俺の MacBook Air on 2024/06/04.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var HomeTableView: UITableView!
    
    var tweets: [Tweets]?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITableViewのデリゲートとデータソースの設定
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
     
        // セルを可変
        HomeTableView.estimatedRowHeight = 50
        HomeTableView.rowHeight = UITableView.automaticDimension
        
        tweets = [
            Tweets(userName: "ゆうた", tweet: "ああああああああああああああああああああ"),
            Tweets(userName: "たろう", tweet: "あああああああああああああああああああああああああああああああああああああ"),
            Tweets(userName: "ユーザー名ユーザー名ユーザー名ユーザー名ユーザー名ユーザー名ユーザー名", tweet: "ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ")
        ]
        
        // セクションあたりの行数を返す
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tweets?.count ?? 0
        }
        
        // セルを構成する
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TweetTableViewCell
            //        cell.img.image = UIImage(systemName: "swift")
            if let tweet = tweets?[indexPath.row] {
                cell.userNameLabel.text = tweet.userName
                cell.tweetLabel.text = tweet.tweet
            }
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
            }
        
        
        // button
        // スクリーンサイズ取得
        let _:CGFloat = self.view.frame.width
        let _:CGFloat = self.view.frame.height
        
        // ボタンサイズ指定
        let buttonWidth: CGFloat = 50
        let buttonHeight: CGFloat = 50
        
        // ボタンに反映（中央に位置調整)
        let x: CGFloat = 330 // 左にずらす量
        let y: CGFloat = 50 // 下にずらす量
        plusButton.frame = CGRect(
            x: x,
            y: y,
            width: buttonWidth,
            height: buttonHeight)
        
        // ボタンの背景色
        plusButton.backgroundColor = UIColor.systemBlue
        
        // アプリ標準のシステム画像を設定
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        // 画像の色をblueに変更
        plusButton.tintColor = .white
        
        // 縦幅・横幅いっぱいに画像を表示
        plusButton.contentHorizontalAlignment = .fill
        plusButton.contentVerticalAlignment = .fill
        
        // ボタンを丸くする(サイズ/2で設定)
        plusButton.layer.cornerRadius = 25
        // 画像を縮小する(マージンのようなもの)
        plusButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        
        // 影の色
        plusButton.layer.shadowColor = UIColor.black.cgColor
        // 影のぼかし？
        plusButton.layer.shadowRadius = 3
        // 影の位置
        plusButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        // 影の濃さ
        plusButton.layer.shadowOpacity = 0.5
        
        // ボタンをViewに追加
        view.addSubview(plusButton)
        
        HomeTableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
    }
}
