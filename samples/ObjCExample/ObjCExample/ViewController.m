//
//  GitpleViewController.m
//  ObjCExample
//
//  Created by Vincent Woo on 3/02/18.
//  Copyright © 2018 Gitple. All rights reserved.
//

#import "ViewController.h"
#import <GitpleSDK/GitpleSDK-Swift.h>
#import <OneSignal/OneSignal.h>

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
    (void)[gitpleUser setMetaWithKey:@"order" value:@"gitple"];
    
    // sendTags for OneSignal : {"gp": "userId"}
    [OneSignal sendTags:@{@"gp" : @"iosobjcuser01"} onSuccess:^(NSDictionary *result) {
        NSLog(@"success!");
    } onFailure:^(NSError *error) {
        NSLog(@"Error - %@", error.localizedDescription);
    }];
    
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
    NSLog(@"onViewLaunchedWithSender");
    
    self.gitpleViewController = sender;
    
    self.gitpleViewController.navigationItem.title = @"Gitple";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(closeGitple:)];
    self.gitpleViewController.navigationItem.rightBarButtonItem = item;
}

- (void)onUnreadCountWithCount:(NSInteger)count {
    NSLog(@"onUnreadCount cunt:%i", (int)count);
}

- (void)closeGitple:(UIBarButtonItem*)sender {
    NSLog(@"closeGitple");
    
    [[self navigationController] dismissViewControllerAnimated:true completion:nil];
}
@end

