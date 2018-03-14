//
//  ViewController.swift
//  SwiftExample
//
//  Created by Vincent Woo on 3/02/18.
//  Copyright © 2018 Gitple. All rights reserved.
//

import UIKit
import GitpleSDK
import OneSignal

class ViewController: UIViewController {
    
    @IBOutlet weak var chatStartButton: UIButton!
    
    let label = UILabel()
    
    private var gitpleViewController: GitpleViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Gitple.delegate = self
        
        Gitple.config().setHideHeader(isHide: true);
        
        Gitple.user().setId(id: "iosswiftuser01")
                     .setEmail(email: "iosswiftuser01@gitple")
                     .setName(name: "iosswiftuser01")
                     .setPhone(phone: "0000000000")
                     .setMeta(key: "company", value: "gitple")
                     .setMeta(key: "order", value: "gitple")
        
        Gitple.unreadCount()
        
        // sendTags for OneSignal : {"gp": "userId"}
        let tags: [AnyHashable : Any] = [
            "gp" : "iosswiftuser01"
        ]
        
        OneSignal.sendTags(tags, onSuccess: { result in
            print("Tags sent - \(result!)")
        }) { error in
            print("Error sending tags: \(error?.localizedDescription ?? "None")")
        }
                
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
        print("onViewLaunched")
        self.gitpleViewController = sender
        
        self.gitpleViewController!.navigationItem.title = "Gitple";
        
        let newBackButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.closeGitple))
        self.gitpleViewController!.navigationItem.rightBarButtonItem = newBackButton;
    }
    
    func onUnreadCount(count: Int) {
        print("onUnreadCount count: \(count)")
    }
    
    @objc func closeGitple(sender: UIBarButtonItem) {
        print("closeGitple")
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
}
