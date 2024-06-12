//
//  tweetViewController.swift
//  TwitterApp
//
//  Created by 俺の MacBook Air on 2024/06/07.
//

import RealmSwift
import UIKit

protocol TweetViewControllerDelegate: AnyObject {
    func didSaveTweet(_ tweet: TweetDataModel)
}

class TweetDataModel: Object {
    @objc dynamic var userName: String = ""
    @objc dynamic var tweet: String = ""
}

class tweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    weak var delegate: TweetViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        loadLatestTweet()
        resetFields()
        tweetView.delegate = self
        userNameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func loadLatestTweet() {
        let realm = try! Realm()
        let tweets = realm.objects(TweetDataModel.self)
        // Realmからデータを読み込む
        if let latestTweet = tweets.last {
            userNameField.text = latestTweet.userName
            tweetView.text = latestTweet.tweet
        }
    }
    @IBAction func saveButton(_ sender: UIButton) {
        
        let tweetData = TweetDataModel()
        tweetData.userName = userNameField.text ?? ""
        tweetData.tweet = tweetView.text ?? ""
        let realm = try! Realm()
        try! realm.write {
            realm.add(tweetData)
        }
        delegate?.didSaveTweet(tweetData)
        navigationController?.popViewController(animated: true)
    }
    // 文字数制限140字
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 140
    }
    // フィールドをリセットするメソッド
    func resetFields() {
        userNameField? .text = ""
        tweetView? .text =  ""
    }
    // TextFieldに打ち込まれてないときにボタンを非活性
    @objc func textFieldDidChange(_ sender: Any) {
        validateInput()
    }
    // TextViewに打ち込まれてないときにボタンを非活性
    func textViewDidChange(_ textView: UITextView) {
        validateInput()
    }
    
    private func validateInput() {
        let isUserNameFieldEmpty = userNameField.text?.isEmpty ?? true
        let isTweetViewEmpty = tweetView.text.isEmpty
        saveButton.isEnabled = !isUserNameFieldEmpty && !isTweetViewEmpty
    }
}
