//
//  TwitterAppTests.swift
//  TwitterAppTests
//
//  Created by 俺の MacBook Air on 2024/06/04.
//

import XCTest
@testable import TwitterApp

class tweetViewController: XCTestCase {
    
    var tweetViewController: tweetViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: Main, bundle: nil)
        self.tweetViewController = storyboard.instantiateInitialViewController() as? tweetViewController
        tweetViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        tweetViewController = nil
        try super.tearDownWithError()
    }

    func testTweetViewCharacterLimit() throws {
        let textView = tweetViewController.tweetView!
        textView.text = ""
        
        // 140文字のテキストを設定
        let maxLengthText = String(repeating: "a", count: 140)
        let oneChar = "a" // 1文字のテキスト
        let range = NSRange(location: textView.text.count, length: 0)
        
        // 141文字目の追加を許可しないかテスト
        textView.text = maxLengthText
        let shouldChange = tweetViewController.textView(textView, shouldChangeTextIn: range, replacementText: oneChar)
        XCTAssertFalse(shouldChange, "140文字を超えるテキストの変更は許可されるべきではありません")
    }
}
