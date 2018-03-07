//
//  ViewController.swift
//  SwiftExample
//
//  Created by Vincent Woo on 3/02/18.
//  Copyright © 2018 Gitple. All rights reserved.
//

import UIKit
import GitpleSDK

let GITPLE_APPCODE = "xxxxxxxxxxxxxxxxxx"

class ViewController: UIViewController {
    
    @IBOutlet weak var chatStartButton: UIButton!
    
    private var gitpleViewController: GitpleViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Gitple.initialize(appCode: GITPLE_APPCODE)
        
        
        Gitple.config().setHideHeader(isHide: true);
        
        Gitple.delegate = self
        
        Gitple.config().setHideHeader(isHide: true);
        
        Gitple.user().setId(id: "iosswiftuser01")
            .setEmail(email: "iosswiftuser01@gitple")
            .setName(name: "iosswiftuser01")
            .setPhone(phone: "0000000000")
            .setMeta(key: "metaKey1", value: "metaValue1")
            .setMeta(key: "metaKey2", value: "metaValue2")
            .setMeta(key: "metaKey3", value: "metaValue4")
        
        Gitple.unreadCount()
        
        chatStartButton.addTarget(self, action: #selector(ViewController.onChatStartButtonClicked), for: UIControlEvents.touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func onChatStartButtonClicked() {
        print("onChatStartButtonClicked")
        Gitple.launch()
    }
}

extension ViewController : GitpleDelegate {
    func onViewLaunched(sender: GitpleViewController) {
        print("onWebviewLaunched")
        self.gitpleViewController = sender
        
        let newBackButton = UIBarButtonItem(title: "닫기", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.done))
        self.gitpleViewController!.navigationItem.rightBarButtonItem = newBackButton;
        
    }
    
    func onUnreadCount(count: Int) {
        print("onUnreadCount count: \(count)")
    }
    
    @objc func done(sender: UIBarButtonItem) {
        print("done")
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
}
