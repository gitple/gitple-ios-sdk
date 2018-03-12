//
//  GitpleViewController.m
//  ObjCExample
//
//  Created by Vincent Woo on 3/02/18.
//  Copyright © 2018 Gitple. All rights reserved.
//

#import "ViewController.h"
#import <GitpleSDK/GitpleSDK-Swift.h>

@interface ViewController () <GitpleDelegate> {
    GitpleViewController* _gitpleViewController;
}

- (IBAction)startChatButton:(id)sender;

@property (nonatomic, retain) GitpleViewController *gitpleViewController;

@end

@implementation ViewController

@synthesize gitpleViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Gitple setDelegate:self];

    (void)[[Gitple config] setHideHeaderWithIsHide:true];
    
    GitpleUser *gitpleUser = [Gitple user];
    
    (void)[gitpleUser setIdWithId:@"iosobjcuser01"];
    (void)[gitpleUser setEmailWithEmail:@"iosobjcuser01@gitple"];
    (void)[gitpleUser setNameWithName:@"iosobjcuser01"];
    (void)[gitpleUser setPhoneWithPhone:@"0000000000"];
    (void)[gitpleUser setMetaWithKey:@"company" value:@"gitple"];
    
    [Gitple unreadCount];
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
    self.gitpleViewController.navigationItem.title = @"채팅 서비스";
}

- (void)onUnreadCountWithCount:(NSInteger)count {
    NSLog(@"onUnreadCount cunt:%i", (int)count);
}

- (void)done:(UIBarButtonItem*)sender {
    NSLog(@"done");
    
    [[self navigationController] dismissViewControllerAnimated:true completion:nil];
}
@end

