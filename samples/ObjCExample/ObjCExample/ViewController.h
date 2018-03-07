//
//  GitpleViewController.h
//  ObjCExample
//
//  Created by Vincent Woo on 3/02/18.
//  Copyright © 2018 Gitple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GitpleSDK/GitpleSDK-Swift.h>

@interface ViewController : UIViewController<GitpleDelegate> {
    GitpleViewController* _gitpleViewController;
}

- (IBAction)startChatButton:(id)sender;

@property (nonatomic, retain) GitpleViewController *gitpleViewController;

@end

