//
//  GitpleViewController.m
//  ObjCExample
//
//  Created by Vincent Woo on 3/02/18.
//  Copyright © 2018 Gitple. All rights reserved.
//

#import "ViewController.h"
#import <GitpleSDK/GitpleSDK-Swift.h>

//@interface ViewController : UIViewController<GitpleDelegate> {
//    GitpleViewController* _gitpleViewController;
//}
//
//
//@property (nonatomic, retain) GitpleViewController *gitpleViewController;


@implementation ViewController

@synthesize gitpleViewController;

#define GITPLE_APPCODE @"xxxxxxxxxxxxxxxxxx"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Gitple initializeWithAppCode:GITPLE_APPCODE];
    
    [[Gitple config] setHideHeaderWithIsHide:true];
    
    [Gitple setDelegate:self];
    
    [[[[[[[[Gitple user]
            setIdWithId:@"iosobjcuser01"]
            setEmailWithEmail:@"iosobjcuser01@gitple"]
            setNameWithName:@"iosobjcuser01"]
            setPhoneWithPhone:@"0000000000"]
            setMetaWithKey:@"metaKey1" value:@"metaValue1"]
            setMetaWithKey:@"metaKey2" value:@"metaValue2"]
            setMetaWithKey:@"metaKey3" value:@"metaValue4"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (IBAction)startChatButton:(id)sender {
    NSLog(@"startChatButton");
    
    [Gitple launch];
}

- (void)onViewLaunchedWithSender:(GitpleViewController * _Nonnull)sender {
    NSLog(@"onWebviewLaunchedWithSender");
    
    self.gitpleViewController = sender;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"닫기"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(done:)];
    self.gitpleViewController.navigationItem.rightBarButtonItem = item;
}

- (void)done:(UIBarButtonItem*)sender {
    NSLog(@"done");
    
    [[self navigationController] dismissViewControllerAnimated:true completion:nil];
}
@end

